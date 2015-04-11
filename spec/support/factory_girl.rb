require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "user#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
  end

  factory :athlete do
    sequence(:first_name) {|n| "#{n}first" }
    sequence(:last_name) {|n| "#{n}last" }
    date_of_birth "0#{rand(10)}/#{rand(10..27)}/#{rand(1980..2010)}"
    gender ["male", "female"].sample
  end

  factory :round do
    sequence(:name) {|n| "Round #{n}" }
    sequence(:number) {|n| n }
    competition
  end

  factory :route do
    sequence(:name) {|n| "Route #{n}" }
    scored_holds rand(8..25)
    round
  end

  factory :competition do
    sequence(:name) {|n| "Comp #{n}" }
    start_date "0#{rand(10)}/#{rand(10..27)}/#{[2016..2017].sample}"
    user
  end
end
