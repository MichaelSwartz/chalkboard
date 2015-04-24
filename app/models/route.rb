class Route < ActiveRecord::Base
  belongs_to :round
  delegate :competition, to: :round

  has_many :attempts
  has_many :highpoints
  has_many :route_ranks, through: :highpoints
  has_many :athletes, through: :highpoints

  validates :name,
    presence: true,
    uniqueness: { scope: :round }
  validates :round, presence: true
  validates :max_score,
    presence: true,
    numericality: true

  after_save :set_default_attempts

  def set_default_attempts
    round.competition.athletes.each do |athlete|
      attempts.create(athlete: athlete, score: 0)
    end
  end

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
    highpoints.find_by(athlete: athlete)
  end

  def athlete_rank(athlete)
    route_ranks.find_by(athlete: athlete).try(:rank)
  end
  #FIX duplicate methods
  def rank_points(athlete)
    route_ranks.find_by(athlete: athlete)
  end

  def top?(athlete)
    athlete_highpoint(athlete).try(:top)
  end

  def score(athlete)
    athlete_highpoint(athlete).try(:score) || 0
  end

  def score_display(athlete)
    if top?(athlete)
      "TOP"
    else
      score(athlete)
    end
  end
end
