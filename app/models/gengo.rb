class Gengo
  include Mongoid::Document
  include RandomFinder

  field :identifier, type: String
  field :surface, type: String

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
end
