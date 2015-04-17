class Competition < ActiveRecord::Base
  belongs_to :user
  has_many :bibs
  has_many :athletes, through: :bibs
  has_many :rounds
  has_many :routes, through: :rounds
  has_many :attempts, through: :routes

  validates :name, presence: true
  validates :user, presence: true
  validates :start_date, presence: true
end
