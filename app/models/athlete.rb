class Athlete < ActiveRecord::Base
  has_many :attempts
  has_many :routes, through: :attempts

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :gender, presence: true
  validates :date_of_birth, presence: true

  def name
    "#{self.first_name} #{self.last_name}"
  end
end
