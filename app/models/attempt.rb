class Attempt < ActiveRecord::Base
  belongs_to :route
  belongs_to :athlete

  validates :athlete, presence: true
  validates :route, presence: true
  validates :score,
    presence: true,
    numericality: true
  validates :number,
    presence: true,
    numericality: true,
    uniqueness: { scope: [:athlete, :route] }
end
