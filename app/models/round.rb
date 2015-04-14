class Round < ActiveRecord::Base
  belongs_to :competition
  has_many :routes

  validates :name, presence: true
  validates :number,
    presence: true,
    numericality: { only_integer: true }
  validates :competition, presence: true
end
