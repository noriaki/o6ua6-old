FactoryGirl.define do
  factory :voting do
    counting_start_at "1999-12-31 23:59:00"
    counting_end_at "2000-01-01 00:00:00"
    votes_count 1
  end
end
