class RoundScore < ActiveRecord::Base
  belongs_to :athlete
  belongs_to :round

  delegate :competition, to: :round

  validates :score,
    presence: true,
    numericality: true
  validates :athlete, presence: true
  validates :round, presence: true
end
