class Athlete < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :gender, presence: true
  validates :date_of_birth, presence: true

  def name
    "#{self.first_name} #{self.last_name}"
  end
end
