class Route < ActiveRecord::Base
  belongs_to :round
  has_many :attempts
  has_many :athletes, through: :attempts

  validates :name, presence: true
  validates :round, presence: true
  validates :scored_holds,
    presence: true,
    numericality: { only_integer: true }

  def highpoints
    array = attempts.to_a.select { |a| a.highpoint? }
    array.sort! { |a, b| [b.score, a.number] <=> [a.score, b.number] }
  end

  def athlete_attempts(athlete)
    attempts.where(athlete: athlete)
  end
end
