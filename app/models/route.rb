class Route < ActiveRecord::Base
  belongs_to :round
  delegate :competition, to: :round

  has_many :attempts
  has_many :athletes, through: :attempts

  validates :name, presence: true
  validates :round, presence: true
  validates :max_score,
    presence: true,
    numericality: true

  def highpoints
    attempts.to_a.select { |a| a.highpoint? }
  end

  def leaderboard
    highpoints.sort_by { |a| [-a.score, a.number] }
  end

  def athlete_attempts(athlete)
    attempts.where(athlete: athlete).order(:created_at)
  end

  def athlete_highpoint(athlete)
    attempts.where(athlete: athlete).order(:score).last
  end

  def attempts_to_highpoint(athlete)
    athlete_highpoint(athlete).number
  end

  def send?(athlete)
    athlete_highpoint(athlete).send?
  end

  def flash?(athlete)
    athlete_highpoint(athlete).flash?
  end

  def score(athlete)
    athlete_highpoint(athlete).score
  end

  def score_display(athlete)
    if send?(athlete)
      "TOP"
    else
      score(athlete)
    end
  end
end
