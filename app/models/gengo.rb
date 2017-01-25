class Gengo
  include Mongoid::Document
  include RandomFinder

  field :identifier, type: String
  field :surface, type: String
  field :display_rating, type: Float, default: 1500.0
  field :rating, type: Float, default: 1500.0
  field :rating_deviation, type: Float, default: 350.0
  field :volatility, type: Float, default: 0.06

  index({ identifier: 1 }, { unique: true, background: true })

  validates_presence_of :identifier
  validates_uniqueness_of :identifier
  validates_length_of :identifier, is: 12
  validates_format_of :identifier, with: /\A[0-9a-z]+\z/

  before_validation IdentifierCallback.new

  def image_urls
    surface.split('').map{|kanji|
      "https://s3-ap-northeast-1.amazonaws.com/o6ua6/images/#{Identifier.identify(kanji)}.jpg"
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

  def to_player
    Glicko2::Player.from_obj self
  end

  class << self
    def find_random(options = {})
      options[:limit] ||= 1
      options[:excepts] ||= []
      self.nin(identifier: options[:excepts]).random(options[:limit].to_i)
    end
  end

  private
  def calc_rating(a_rating, b_rating)
    d_rating = 16 + (b_rating - a_rating) * 0.04
    d_rating = d_rating < 1.0 ? 1.0 : (d_rating > 31.0 ? 31.0 : d_rating)
    [ a_rating + d_rating, b_rating - d_rating ]
  end
end
