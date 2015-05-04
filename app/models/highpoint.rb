class Highpoint < ActiveRecord::Base
  belongs_to :attempt
  belongs_to :athlete
  belongs_to :route
  has_one :route_rank

  delegate :score, to: :attempt, allow_nil: true
  delegate :number, to: :attempt, allow_nil: true
  delegate :round, to: :route
  delegate :css_class, to: :attempt

  validates :attempt, presence: true
  validates :athlete, presence: true
  validates :route, presence: true

  after_save :update_ranks

  def update_ranks
    route.update_ranks
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

  def css_class
    if top?
      "top"
    else
      "other"
    end
  end
end
