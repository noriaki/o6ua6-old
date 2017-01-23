require 'rails_helper'

RSpec.describe 'concerns/Identifier' do
  describe :identify do
    let(:kanji) { attributes_for(:kanji) }
    let(:klass) { Class.new{ include Identifier } }

    it 'takes :string(surface) and returns :string(identifier)' do
      subject = klass.identify kanji[:surface]
      expect(subject).to eql(kanji[:identifier])
    end
  end
end
