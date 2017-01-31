class Kanji
  include Mongoid::Document
  include RandomFinder
  include SeedsImporter

  field :identifier, type: String
  field :surface, type: String

  index({ identifier: 1 }, { unique: true, background: true })

  validates_presence_of :identifier
  validates_uniqueness_of :identifier
  validates_length_of :identifier, is: 6
  validates_format_of :identifier, with: /\A[0-9a-z]+\z/

  before_validation IdentifierCallback.new

  def image_url
    "https://#{Aws::S3.bucket_name}.s3.amazonaws.com/images/#{identifier}.jpg"
  end

  class << self
    def import!
      filepath = Rails.root.join 'db', 'KanjiCandidates.json'
      self.import_from_json(filepath)
    end
  end
end
