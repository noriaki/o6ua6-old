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

    it :rating do
      is_expected.to have_fields(:rating)
                      .of_type(Float)
                      .with_default_value_of(1500.0)
    end

    it :display_rating do
      is_expected.to have_fields(:display_rating)
                      .of_type(Float)
                      .with_default_value_of(1500.0)
    end

    it :rating_deviation do
      is_expected.to have_fields(:rating_deviation)
                      .of_type(Float)
                      .with_default_value_of(350.0)
    end

    it :volatility do
      is_expected.to have_fields(:volatility)
                      .of_type(Float)
                      .with_default_value_of(0.06)
    end
  end

  describe "methods" do
    let(:gengo) { create(:gengo) }

    it :image_url do
      subject = gengo.image_urls
      expected = [
        "https://#{Aws::S3.bucket_name}.s3.amazonaws.com/images/38ab5e.jpg",
        "https://#{Aws::S3.bucket_name}.s3.amazonaws.com/images/ea4a5e.jpg"
      ]
      expect(subject).to eql(expected)
    end

    describe "#won(other)" do
      let(:winner) { create(:gengo_winner) }
      let(:loser) { create(:gengo_loser) }

      describe "call private method `calc_rating(winner_rating, loser_rating)`" do
        it "return calculated [winner_rating, loser_rating]" do
          expect(
            winner.__send__(:calc_rating,
                            winner.display_rating, loser.display_rating)
          ).to eql([winner.display_rating + 20.0, loser.display_rating - 20.0])
        end
      end

      it "change winner display_rating + in DB" do
        winner_rating = attributes_for(:gengo_winner)[:display_rating]
        expect{ winner.won(loser) }.to(
          change{ winner.display_rating }
          .from(winner_rating).to(winner_rating + 20)
        )
        expect(winner.changed?).to be false
        expect(winner.reload.display_rating).to eql(winner_rating + 20)
      end

      it "change loser display_rating - in DB" do
        loser_rating = attributes_for(:gengo_loser)[:display_rating]
        expect{ winner.won(loser) }.to(
          change{ loser.display_rating }
          .from(loser_rating).to(loser_rating - 20)
        )
        expect(loser.changed?).to be false
        expect(loser.reload.display_rating).to eql(loser_rating - 20)
      end
    end

    describe "#lost(other)" do
      let(:loser) { create(:gengo_loser) }

      it "call to other#won(self)" do
        subject = spy("Gengo")
        loser.lost(subject)
        expect(subject).to have_received(:won).with(loser)
      end
    end

    describe "#attributes_will_change - serialized" do
      before(:each) do
        gengo.id = '__test__'
        gengo.identifier = 'a' * 12
        gengo.rating -= 100
        gengo.rating_deviation -= 30
      end

      it "return Hash except `_id`" do
        expect(gengo.attributes_will_change).not_to including('_id')
      end

      it "return Hash only will changing" do
        expect(gengo.attributes_will_change.symbolize_keys).to(
          including(
            identifier: 'a' * 12,
            rating: attributes_for(:gengo)[:rating] - 100,
            rating_deviation: attributes_for(:gengo)[:rating_deviation] - 30
          )
        )
      end
    end

    describe ".bulk_update" do
      it "pass args Array of operation -> [{ filter, operations }]" do
        operations = create_list(:random_gengo, 4).map{|g|
          [ { identifier: g.identifier }, { display_rating: g.rating + 100 } ]
        }
        result = Gengo.bulk_update(operations)
        expect(result.modified_count).to eql(4)
        Gengo.each{|g| expect(g.display_rating).to eql(g.rating + 100) }
      end

      it "pass args Array of instance -> [instance]" do
        instances = create_list(:random_gengo, 4).map{|g|
          g.display_rating = g.rating + 100; g
        }
        result = Gengo.bulk_update(instances)
        expect(result.modified_count).to eql(4)
        Gengo.each{|g| expect(g.display_rating).to eql(g.rating + 100) }
      end
    end
  end
end
