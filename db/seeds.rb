# require 'faker'
#
# user = User.create(password: "password", email: "m@s.com", admin: true)
# other_user = User.create(password: "password", email: "s@m.com", admin: true)
#
# users = [user, other_user]
#
# athletes = []
#
# 60.times do
#   athletes << Athlete.create(
#     first_name: Faker::Name.first_name,
#     last_name: Faker::Name.last_name,
#     date_of_birth: Faker::Date.between(30.years.ago, 14.years.ago),
#     gender: ["Male", "Female"].sample,
#     team: Faker::Address.city,
#   )
# end
#
# competitions = []
#
# 10.times do
#   competitions << Competition.create(
#     name: Faker::Commerce.product_name,
#     user: users.sample,
#     start_date: Faker::Date.between(1.year.ago, next_year),
#   )
# end
#
# 10.times do
#   date = Faker::Date.between(1.year.ago, next_year)
#   competitions << Competition.create(
#     name: Faker::Commerce.product_name,
#     user: users.sample,
#     gender: ["Male", "Female"].sample,
#     division: ["Open", "Youth A", "Youth B", "Youth C"].sample,
#     start_date: date,
#     end_date: date + rand(3),
#     gym: ["BKB", "Movement", "CRG", "Metro", "BRG", "GMRCC"].sample,
#     city: ["Somerville", "Boulder", "Watertown", "Rutland"].sample,
#     state: ["MA", "CO", "VT"].sample
#   )
# end
#
# rounds = []
# round_names = ["Qualifiers", "Semifinals", "Finals"]
#
# competitions.each do |comp|
#   rand(1..3).times do [i]
#     round << Rounds.create(
#       name: round_names[i],
#       number: i + 1,
#       user: users.sample
#     )
#   end
# end
#
#
#
# users = []
#
# 20.times do
#   users << User.create_with(
#     password: Faker::Lorem.characters(10)).
#     find_or_create_by(email: Faker::Internet.email)
# end
#
# 60.times do
#   airlines << Airline.find_or_create_by(
#     name: Faker::Company.name,
#     link_url: Faker::Internet.url,
#     logo_url: Faker::Company.logo,
#     description: Faker::Company.bs,
#     user_id: users.sample.id
#   )
#
# end
#
# 10000.times do
#   Review.create(
#     user_id: users.sample.id,
#     rating: (rand(1..4)),
#     body: Faker::Lorem.sentence,
#     airline_id: airlines.sample.id
#   )
# end
