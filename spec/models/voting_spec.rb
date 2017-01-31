require 'rails_helper'

RSpec.describe Voting, type: :model do
  describe "fields" do
    it :counting_start_at do
      is_expected.to have_fields(:counting_start_at).of_type(ActiveSupport::TimeWithZone)
      is_expected.to have_index_for(counting_start_at: -1)
                      .with_options(background: true)
    end
    it :counting_end_at do
      is_expected.to have_fields(:counting_end_at).of_type(ActiveSupport::TimeWithZone)
      is_expected.to have_index_for(counting_end_at: -1)
                      .with_options(background: true)
    end
    it :votes_count do
      is_expected.to have_fields(:votes_count).of_type(Integer)
    end
  end

  describe "methods" do
    let(:voting) { create(:voting) }

    it "#to_h" do
      expect(voting.to_h).not_to include :_id
      expect(voting.to_h).to include :id,
                                     :counting_start_at,
                                     :counting_end_at,
                                     :votes_count
    end

    it "#filename" do
      expect(voting.filename).to eql("voting_20000101-000000_#{voting.id}")
    end

    it "#backup(votes: Iteratable<Gengo>)" do
      create :vote
      allow(Aws::S3::Bucket).to receive(:new).and_wrap_original{|m, *args|
        m.call(*args, stub_responses: { put_object: { etag: 'test-obj' } })
      }
      expect(voting).to receive(:to_h).and_call_original.once
      expect(voting).to receive(:filename).and_call_original.once
      expect{
        expect(voting.backup(Vote.all)).to(
          respond_to(:etag).
          and have_attributes(etag: 'test-obj')
        )
      }.not_to raise_error
    end

    it ".term(end_time: Time)" do
      voting
      current_time = Time.zone.now
      subject = Voting.term(current_time)
      expect(subject).to be_a(Range)
      expect(subject.first).to eql voting.counting_end_at
      expect(subject.end).to eql current_time
    end
  end
end
