class Gengo
  DEFAULT_BULK_UPDATE_OPTIONS =
    { bypass_document_validation: false, ordered: false }
  @@defaults = {
    display_rating: Glicko2::DEFAULT_GLICKO_RATING,
    rating: Glicko2::DEFAULT_GLICKO_RATING,
    rating_deviation: Glicko2::DEFAULT_GLICKO_RATING_DEVIATION,
    volatility: Glicko2::DEFAULT_VOLATILITY
  }
  cattr_reader :defaults

  include Mongoid::Document
  include RandomFinder
  include SeedsImporter

  field :identifier, type: String
  field :surface, type: String
  field :display_rating, type: Float, default: @@defaults[:display_rating]
  field :rating, type: Float, default: @@defaults[:rating]
  field :rating_deviation, type: Float, default: @@defaults[:rating_deviation]
  field :volatility, type: Float, default: @@defaults[:volatility]

  index({ identifier: 1 }, { unique: true, background: true })

  validates_presence_of :identifier
  validates_uniqueness_of :identifier
  validates_length_of :identifier, is: 12
  validates_format_of :identifier, with: /\A[0-9a-z]+\z/

  before_validation IdentifierCallback.new

  def image_urls
    surface.split('').map{|kanji|
      "https://#{Aws::S3.bucket_name}.s3.amazonaws.com/images/#{Identifier.identify(kanji)}.jpg"
    }
  end

  def won(other)
    winner_rating, loser_rating =
                   calc_rating(self.display_rating, other.display_rating)
    self.update(display_rating: winner_rating)
    other.update(display_rating: loser_rating)
  end

  def lost(other)
    other.won(self)
  end

  def attributes_will_change
    changed.dup.reduce({}){|h,k|
      h[k] = self.send(k) unless k == '_id'; h }.with_indifferent_access
  end

  def to_player
    Glicko2::Player.from_obj self
  end

  class << self
    def import!
      filepath = Rails.root.join 'db', 'GengoCandidates.json'
      self.import_from_json(filepath, @@defaults)
    end

    def find_random(options = {})
      options[:limit] ||= 1
      options[:excepts] ||= []
      self.nin(identifier: options[:excepts]).random(options[:limit].to_i)
    end

    def bulk_update(operations)
      self.collection.bulk_write(
        operations.map {|operation|
          if operation.is_a? Array
            { update_one: {
                filter: operation[0],
                update: { '$set' => operation[1] }
              } }
          elsif operation.is_a? self
            { update_one: {
                filter: { identifier: operation.identifier },
                update: { '$set' => operation.attributes_will_change }
              } }
          end
        }, DEFAULT_BULK_UPDATE_OPTIONS
      )
    end
  end

  private
  def calc_rating(a_rating, b_rating)
    d_rating = 16 + (b_rating - a_rating) * 0.04
    d_rating = d_rating < 1.0 ? 1.0 : (d_rating > 31.0 ? 31.0 : d_rating)
    [ a_rating + d_rating, b_rating - d_rating ]
  end
end
