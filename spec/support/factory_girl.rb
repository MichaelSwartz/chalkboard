require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "user#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
  end

  factory :athlete do
    sequence(:first_name) { |n| "#{n}first" }
    sequence(:last_name) { |n| "#{n}last" }
    sequence(:date_of_birth) { |n| Date.new(1995, 11, 11) }
    gender "female"
  end

  factory :round do
    sequence(:name) {|n| "Round #{n}" }
    sequence(:number) {|n| n }
    competition
  end

  factory :route do
    sequence(:name) {|n| "Route #{n}" }
    sequence(:max_score) {|n| n + 8.25 }
    round
  end

  factory :competition do
    sequence(:name) {|n| "Comp #{n}" }
    start_date Date.new(2015, 12, 12)
    user
  end
end
