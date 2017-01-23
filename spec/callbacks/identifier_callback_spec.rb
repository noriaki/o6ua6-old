require 'rails_helper'

RSpec.describe IdentifierCallback do
  let(:subject) { build(:kanji, identifier: nil) }
  let(:expected) { build(:kanji) }

  it :identify do
    IdentifierCallback.new.before_validation(subject)
    expect(subject.identifier).to eql(expected.identifier)
  end
end
