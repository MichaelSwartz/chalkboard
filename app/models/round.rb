class Round < ActiveRecord::Base
  belongs_to :competition
  has_many :routes
  has_many :attempts, through: :routes
  has_many :athletes, through: :attempts

  validates :competition, presence: true
  validates :name, presence: true
  validates :number,
    presence: true,
    numericality: { only_integer: true }

  def leaderboard
    athletes
  end
end
