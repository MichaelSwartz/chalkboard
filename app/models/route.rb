class Route < ActiveRecord::Base
  belongs_to :round
  has_many :attempts

  validates :name, presence: true
  validates :round, presence: true
  validates :scored_holds,
    presence: true,
    numericality: { only_integer: true }
end
