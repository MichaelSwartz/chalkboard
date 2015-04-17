require 'faker'

athletes = []
competitions = []
bibs = []
rounds = []
routes = []

a = User.new(password: "password", email: "a@a.com")
b = User.new(password: "password", email: "b@a.com")
a.save!
b.save!
users = [a, b]

60.times do
  athletes << Athlete.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    date_of_birth: Faker::Date.between(30.years.ago, 14.years.ago),
    gender: ["Male", "Female"].sample,
    team: Faker::Address.city,
  )
end

10.times do
  competitions << users.sample.competitions.create(
    name: Faker::Commerce.product_name,
    start_date: Faker::Date.between(1.year.ago, Date.today),
  )
end

10.times do
  date = Faker::Date.between(1.year.ago, Date.today)
  competitions << users.sample.competitions.create(
    name: Faker::Commerce.product_name,
    user: users.sample,
    gender: ["Male", "Female"].sample,
    division: ["Open", "Youth A", "Youth B", "Youth C"].sample,
    start_date: date,
    end_date: date + rand(3),
    gym: ["BKB", "Movement", "CRG", "Metro", "BRG", "GMRCC"].sample,
    city: ["Somerville", "Boulder", "Watertown", "Rutland"].sample,
    state: ["MA", "CO", "VT"].sample
  )
end

round_names = ["Qualifiers", "Semifinals", "Finals"]

competitions.each do |comp|
  rand(10..20).times do |i|
    bibs << comp.bibs.create_with(bib: i).find_or_create_by(
      athlete: athletes.sample)
  end
end

competitions.each do |comp|
  rand(1..3).times do |i|
    rounds << comp.rounds.create(
      name: round_names[i],
      number: i + 1,
    )
  end
end

rounds.each do |round|
  if round.number == 1
    rand(2..5).times do |i|
      routes << round.routes.create(
        name: "#{i} Faker::Commerce.color",
        max_score: rand(10..20)
      )
    end
  else
    routes << round.routes.create(
      name: Faker::Commerce.color,
      max_score: rand(10..20)
    )
  end
end

# routes.each do |route|
#   route.round.competition.bibs.each do |bib|
#     rand(1..5).times do
#       route.attempts.create(
#         athlete: bib.athlete,
#         score: rand(3..route.max_score)
#       )
#     end
#   end
# end
