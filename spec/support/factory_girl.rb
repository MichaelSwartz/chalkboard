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
    sequence(:date_of_birth) { |n| "0#{n}/0#{n}/199#{n}" }
    gender "female"
  end

  factory :round do
    sequence(:name) {|n| "Round #{n}" }
    sequence(:number) {|n| n }
    competition
  end

  factory :route do
    sequence(:name) {|n| "Route #{n}" }
    sequence(:scored_holds) {|n| n + 8 }
    round
  end

  factory :competition do
    sequence(:name) {|n| "Comp #{n}" }
    sequence(:start_date) {|n| "0#{n}/0#{n}/201#{n}" }
    user
  end
end
