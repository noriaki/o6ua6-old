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
                      .not_to_allow('0')
                      .not_to_allow('a')
                      .not_to_allow('ABC123')
      is_expected.to have_index_for(identifier: 1)
                      .with_options(unique: true, background: true)
    end
  end

  describe "methods" do
    let(:kanji) { create(:kanji) }

    it :image_url do
      subject = kanji.image_url
      expect(subject).to eql("https://s3-ap-northeast-1.amazonaws.com/o6ua6/images/#{kanji.identifier}.jpg")
    end
  end
end
