require 'rails_helper'

RSpec.describe Vote, type: :model do
  describe "fields" do
    it :uid do
      is_expected.to have_fields(:uid).of_type(String)
      is_expected.to validate_presence_of(:uid)
      is_expected.to validate_length_of(:uid).is(6)
    end
    it :winner do
      is_expected.to have_fields(:winner).of_type(String)
      is_expected.to validate_presence_of(:winner)
      is_expected.to validate_length_of(:winner).is(12)
    end
    it :loser do
      is_expected.to have_fields(:loser).of_type(String)
      is_expected.to validate_presence_of(:loser)
      is_expected.to validate_length_of(:loser).is(12)
    end
    it :c_at do
      is_expected.to have_fields(:c_at).of_type(Time)
      is_expected.to have_index_for(c_at: -1)
                      .with_options(background: true)
    end
  end

  describe "methods" do
    describe "(logging vote results)" do
      let(:uid) { attributes_for(:vote)[:uid] }
      let(:winner) { create(:gengo_winner) }
      let(:loser) { create(:gengo_loser) }

      it ".apply(uid, winner, loser) create a entity" do
        expect{ Vote.apply(uid, winner, loser) }.to change{ Vote.count }.by(1)
      end
    end

    describe "counting votes to Gengo" do
      let(:subject) { create :vote }
      let(:winner) { create :gengo_winner }
      let(:loser) { create :gengo_loser }
      let(:log_format) {
        attr = attributes_for :vote
        "#{attr[:uid]}|#{attr[:winner]}/#{attr[:loser]}"
      }

      it "#to_log" do
        expect(subject.to_log).to eql(log_format)
      end

      it ".to_log" do
        2.times{ create :vote }
        expected = Array.new(2, log_format).join("\n")
        expect(Vote.to_log).to eql(expected)
      end
    end
  end
end
