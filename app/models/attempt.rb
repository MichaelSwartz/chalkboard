class Attempt < ActiveRecord::Base
  belongs_to :route
  belongs_to :athlete

  validates :athlete, presence: true
  validates :route, presence: true
  validates :score,
    presence: true,
    numericality: true

  def number
    athlete_attempts(athlete).rindex(self) + 1
  end

  def highpoint?
    self == route.athlete_highpoint(athlete)
  end

  def send?
    score == route.max_score
  end

  def flash?
    send? && number == 1
  end

  def score_display
    if send?
      "send"
    else
      score
    end
  end

  def class
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
