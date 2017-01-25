# coding: utf-8
FactoryGirl.define do
  factory :gengo do
    identifier "ea4a5e38ab5e"
    surface "広央"
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
end
