class Round < ActiveRecord::Base
  belongs_to :competition
  has_many :routes
  has_many :attempts, through: :routes
  has_many :athletes, through: :attempts
  has_many :round_scores

  validates :competition, presence: true
  validates :name,
    presence: true,
    uniqueness: { scope: :competition }
  validates :number,
    presence: true,
    numericality: { only_integer: true },
    uniqueness: { scope: :competition }

  def leaderboard
    round_scores.order(tops: :desc, score: :asc)
  end

  def single_route?
    route_count == 1
  end

  def first_round?
    previous_round.nil?
  end

  def previous_round
    competition.rounds.find_by(number: (number - 1))
  end

  def top_count(athlete)
    tops = 0
    routes.each do |route|
      tops += 1 if route.top?(athlete)
    end
    tops
  end

  def round_score(athlete)
    round_scores.find_by(athlete: athlete).try(:score)
  end

  def round_tops(athlete)
    round_scores.find_by(athlete: athlete).try(:tops)
  end

  def route_count
    routes.count
  end

  def update_scores
    athletes.uniq.each do |athlete|
      total_score = routes.inject(1) do |product, route|
        product * (route.athlete_rank(athlete) || 0)
        # '|| 0' prevents errors when setting defaults
      end

      round_score = round_scores.find_or_initialize_by(athlete: athlete)
      round_score.score = (total_score.to_f**(1 / route_count.to_f)).round(2)
      round_score.tops = top_count(athlete)
      round_score.save
    end
  end
end
