class Competition < ActiveRecord::Base
  belongs_to :user
  has_many :rounds
  has_many :routes, through: :rounds
  has_many :attempts, through: :routes
  has_many :athletes, through: :attempts

  validates :name, presence: true
  validates :user, presence: true
  validates :start_date, presence: true
end
