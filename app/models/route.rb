class Route < ActiveRecord::Base
  belongs_to :round
  delegate :competition, to: :round

  has_many :attempts
  has_many :highpoints
  has_many :route_ranks, through: :highpoints
  has_many :athletes, through: :highpoints

  validates :name, presence: true
  validates :round, presence: true
  validates :max_score,
    presence: true,
    numericality: true

  def leaderboard
    route_ranks.order(:rank)
  end

  def attempts_to_highpoint(athlete)
    athlete_highpoint(athlete).try(:number) || 0
  end

  def athlete_attempts(athlete)
    attempts.where(athlete: athlete).order(:created_at)
  end

  def athlete_highpoint(athlete)
    highpoints.where(athlete: athlete)
  end

  def athlete_rank(athlete)
    route_ranks.find_by(athlete: athlete)
  end

  def send?(athlete)
    athlete_highpoint(athlete).try(:send?)
  end

  def score(athlete)
    athlete_highpoint(athlete).try(:score) || 0
  end

  def rank_points(athlete)
    route_ranks.find_by(athlete: athlete)
  end

  def score_display(athlete)
    if send?(athlete)
      "TOP"
    else
      score(athlete)
    end
  end
end
