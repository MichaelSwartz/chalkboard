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

  def validate_within_max_score
    if score
      unless score <= route.max_score
        errors.add(:score,
          "cannot be higher than route maximum score of #{route.max_score}")
      end
    end
  end

  def number
    route.athlete_attempts(athlete).rindex(self) + 1
  end

  def highpoint?
    self == route.athlete_highpoint(athlete)
  end

  def send?
    score == route.max_score
  end

  def flash?
    send? && flash_attempt?
  end

  def flash_attempt?
    number == 1
  end

  def score_display
    if send?
      "TOP"
    else
      score
    end
  end

  def css_class
    if flash?
      "flash"
    elsif send?
      "send"
    elsif highpoint?
      "highpoint"
    else
      "other"
    end
  end
end
