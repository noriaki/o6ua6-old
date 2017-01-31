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
  end
end
