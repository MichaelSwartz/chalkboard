class Athlete < ActiveRecord::Base
  has_many :attempts
  has_many :routes, through: :attempts
  has_many :rounds, through: :routes
  has_many :competitions, through: :rounds

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :gender, presence: true
  validates :date_of_birth, presence: true

  def name
    "#{first_name} #{last_name}"
  end

  def name_last_first
    "#{last_name}, #{first_name}"
  end

  def highpoint(route)
    self.attempts.order(score: :desc).where(route: route).take
  end

  def standing(route)
    index = route.highpoints.rindex(highpoint(route))
    index - ties + 1
  end


end
