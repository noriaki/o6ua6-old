require 'rails_helper'

RSpec.describe Kanji, type: :model do
  describe "fields" do
    it :identifier do
      is_expected.to have_fields(:identifier).of_type(String)
      is_expected.to validate_presence_of(:identifier)
      is_expected.to validate_uniqueness_of(:identifier)
      is_expected.to validate_length_of(:identifier).is(6)
      is_expected.to validate_format_of(:identifier)
                      .to_allow('012345')
                      .to_allow('abcdef')
                      .to_allow('abc123')
                      .not_to_allow('')
                      .not_to_allow('-')
                      .not_to_allow('ABC123')
      is_expected.to have_index_for(identifier: 1)
                      .with_options(unique: true, background: true)
    end
  end

  describe "methods" do
    let(:kanji) { create(:kanji) }

    it :image_url do
      subject = kanji.image_url
      expected =
        "https://#{Aws::S3.bucket_name}.s3.amazonaws.com/images/#{kanji.identifier}.jpg"
      expect(subject).to eql(expected)
    end
  end
end
