# coding: utf-8
FactoryGirl.define do
  factory :gengo do
    identifier "ea4a5e38ab5e"
    surface "広央"
    rating 1900.0
    rating_deviation 200.0
  end

  factory :gengo_winner, class: Gengo do
    identifier "1a0a6efa988e"
    surface "良校"
    display_rating 1400.0
    rating 1400.0
    rating_deviation 350.0
    volatility 0.06
  end

  factory :gengo_loser, class: Gengo do
    identifier "5a7b5e2b3a5e"
    surface "売工"
    display_rating 1500.0
    rating 1500.0
    rating_deviation 350.0
    volatility 0.06
  end

  factory :random_gengo, class: Gengo do
    sequence(:identifier){|n| (n % (10 ** 12)).to_s.rjust(12, 'g')[-12, 12] }
    sequence(:surface){|n| (n % (10 ** 2)).to_s.rjust(2, 's')[-2, 2] }
    display_rating 1500.0
    rating 1500.0
    rating_deviation 350.0
    volatility 0.06

    to_create {|instance| instance.save(validate: false) }
  end
end
