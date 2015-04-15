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
end
