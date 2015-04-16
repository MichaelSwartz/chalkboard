class Attempt < ActiveRecord::Base
  belongs_to :route
  belongs_to :athlete

  validates :athlete, presence: true
  validates :route, presence: true
  validates :score,
    presence: true,
    numericality: true

  def number
    all = route.athlete_attempts(athlete).to_a
    all.sort! { |a, b| a.created_at <=> b.created_at }
    all.rindex(self) + 1
  end

  def highpoint?
    all = route.athlete_attempts(athlete).sort { |a, b| a.score <=> b.score }
    self == all.last
  end
end
