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

      describe ".dispose(players: Array<Gengo>)" do
        before(:each) { create :vote }
        let(:inactive) { create :gengo }

        it "calcrate rating and associated values" do
          expect{ Vote.dispose([inactive, winner, loser]) }.to(
            change{ winner.rating }.by_at_least(0).
            and change{ loser.rating }.by_at_most(0).
            and change{ inactive.rating }.by(0).
            and change{ winner.rating_deviation }.by_at_most(0).
            and change{ loser.rating_deviation }.by_at_most(0).
            and change{ inactive.rating_deviation }.by_at_least(0)
          )
        end

        it "return calcurated players: Array<Gengo>" do
          expect(Vote.dispose([inactive, winner, loser])).to(
            be_an(Array).and containing_exactly(inactive, winner, loser)
          )
        end
      end

      describe ".counting transaction" do
        let(:inactive) { create(:gengo) }
        let(:voting) { create :voting }
        before(:each) {
          voting
          2.times{ create :vote }
          [winner, loser, inactive]
        }

        context "when error occurred in Vote.dispose" do
          it "will not change player(Gengo)'s data" do
            expect(Vote).to receive(:dispose).and_raise('error')
            expect{ Vote.counting }.not_to(
              change{ [ winner, loser, inactive ].map(&:reload).map(&:rating) }
            )
          end
        end
        context "when error occurred in Gengo.bulk_update"
        context "when error occurred in Voting#backup" do
          before(:each) do
            expect(Gengo).to receive(:bulk_update).twice.and_call_original
          end

          it "destroy created voting data" do
            expect(Voting).to receive(:create).and_wrap_original{|m, *args|
              vtg = m.call(*args)
              expect(vtg).to receive(:backup).once.and_raise('error')
              expect(vtg).to receive(:destroy).once.and_call_original
              vtg
            }
            expect{ Vote.counting }.not_to change{ Voting.count }
          end

          it "rollback to player(Gengo)'s data" do
            expect(Voting).to receive(:create).and_wrap_original{|m, *args|
              vtg = m.call(*args)
              expect(vtg).to receive(:backup).once.and_raise('error')
              vtg
            }
            expect{ Vote.counting }.not_to(
              change{ [ winner, loser, inactive ].map(&:reload).map(&:rating) }
            )
          end
        end
        context "when no error occured" do
          it "destroy all target votes in after process" do
            expect{ Vote.counting }.to change{ Vote.count }.from(2).to(0)
          end

          it "not destroy non-target votes" do
            non_target_vote = create :vote, c_at: "1999-12-31 23:59:30"
            expect{ Vote.counting }.to change{ Vote.count }.from(3).to(1)
            expect(Vote.first.c_at).to eql(non_target_vote.c_at)
          end

          it "record voting with 2 votes count, counting_start_at" do
            Vote.counting
            subject = Voting.first
            expect(subject.votes_count).to eql 2
            expect(subject.counting_start_at).to eql voting.counting_end_at
          end
        end
      end
    end
  end
end
