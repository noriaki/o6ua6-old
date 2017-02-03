class Gengo
  DEFAULT_BULK_UPDATE_OPTIONS =
    { bypass_document_validation: false, ordered: false }.freeze
  @defaults = {
    display_rating: Glicko2::DEFAULT_GLICKO_RATING,
    rating: Glicko2::DEFAULT_GLICKO_RATING,
    rating_deviation: Glicko2::DEFAULT_GLICKO_RATING_DEVIATION,
    volatility: Glicko2::DEFAULT_VOLATILITY
  }
  attr_reader :defaults

  include Mongoid::Document
  include RandomFinder
  include SeedsImporter

  field :identifier, type: String
  field :surface, type: String
  field :display_rating, type: Float, default: @defaults[:display_rating]
  field :rating, type: Float, default: @defaults[:rating]
  field :rating_deviation, type: Float, default: @defaults[:rating_deviation]
  field :volatility, type: Float, default: @defaults[:volatility]

  index({ identifier: 1 }, { unique: true, background: true })

  validates :identifier,
            presence: true,
            uniqueness: true,
            length: { is: 12 },
            format: { with: /\A[0-9a-z]+\z/ }

  before_validation IdentifierCallback.new

  def image_urls
    surface.split('').map do |kanji|
      "https://#{Aws::S3.bucket_name}.s3.amazonaws.com" \
      "/images/#{Identifier.identify(kanji)}.jpg"
    end
  end

  def won(other)
    w_rating, l_rating = calc_rating display_rating, other.display_rating
    update display_rating: w_rating
    other.update display_rating: l_rating
  end

  def lost(other)
    other.won(self)
  end

  def attributes_will_change
    changed.dup.without('_id').each_with_object({}) do |key, ret|
      ret[key] = send(key)
    end.with_indifferent_access
  end

  def to_player
    Glicko2::Player.from_obj self
  end

  class << self
    def import!
      filepath = Rails.root.join 'db', 'GengoCandidates.json'
      import_from_json(filepath, @defaults)
    end

    def find_random(options = {})
      options[:limit] ||= 1
      options[:excepts] ||= []
      nin(identifier: options[:excepts]).random(options[:limit].to_i)
    end

    def bulk_update(operations)
      collection.bulk_write(
        operations.map do |operation|
          { update_one: build_operation(operation) }
        end, DEFAULT_BULK_UPDATE_OPTIONS
      )
    end

    private

    def build_operation(operation)
      if operation.is_a? Array
        { filter: operation[0], update: { '$set' => operation[1] } }
      elsif operation.is_a? self
        {
          filter: { identifier: operation.identifier },
          update: { '$set' => operation.attributes_will_change }
        }
      end
    end
  end

  private

  def calc_rating(a_rating, b_rating)
    d_rating = 16 + (b_rating - a_rating) * 0.04
    d_rating = d_rating < 1.0 ? 1.0 : (d_rating > 31.0 ? 31.0 : d_rating)
    [a_rating + d_rating, b_rating - d_rating]
  end
end
