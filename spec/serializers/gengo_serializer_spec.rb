require 'rails_helper'

RSpec.describe GengoSerializer do
  let(:gengo) { build(:gengo) }
  let(:serializer) { GengoSerializer.new(gengo) }
  subject do
    JSON.parse(ActiveModelSerializers::Adapter.create(serializer).to_json)
  end

  describe :attributes do
    it { is_expected.to include('identifier') }
    it { is_expected.to include('surface') }
    it { is_expected.to include('yomi') }
    it { is_expected.to include('imageUrls') }
  end
end
