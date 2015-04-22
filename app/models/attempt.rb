class Attempt < ActiveRecord::Base
  belongs_to :route
  belongs_to :athlete

  delegate :round, to: :route
  delegate :competition, to: :round
  delegate :athletes, to: :competition

  validates :athlete, presence: true
  validates :route, presence: true
  validates :score,
    presence: true,
    numericality: { greater_than_or_equal_to: 0 }
  validate :validate_within_max_score, on: [:create, :update]

  after_save :update_highpoint

  def update_highpoint
    highpoint = Highpoint.find_or_initialize_by(athlete: athlete, route: route)
    if highpoint.score.nil? || (score > highpoint.score)
      highpoint.attempt = self
      highpoint.top = top?
      highpoint.save
    end
  end

  def validate_within_max_score
    if score
      unless score <= route.max_score
        errors.add(:score,
          "cannot be higher than route maximum score of #{route.max_score}")
      end
    end
  end

  def number
    route.athlete_attempts(athlete).rindex(self)
  end

  def highpoint?
    self == route.athlete_highpoint(athlete)
  end

  def top?
    score == route.max_score
  end

  def score_display
    if top?
      "TOP"
    else
      score
    end
  end
end
