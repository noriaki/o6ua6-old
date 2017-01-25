require 'rails_helper'

RSpec.describe Gengo, type: :model do
  describe "fields" do
    it :identifier do
      is_expected.to have_fields(:identifier).of_type(String)
      is_expected.to validate_presence_of(:identifier)
      is_expected.to validate_uniqueness_of(:identifier)
      is_expected.to validate_length_of(:identifier).is(12)
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
    let(:gengo) { create(:gengo) }

    it :image_url do
      subject = gengo.image_urls
      expected = [
        "https://s3-ap-northeast-1.amazonaws.com/o6ua6/images/38ab5e.jpg",
        "https://s3-ap-northeast-1.amazonaws.com/o6ua6/images/ea4a5e.jpg"
      ]
      expect(subject).to eql(expected)
    end
  end
end
