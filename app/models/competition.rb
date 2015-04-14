class Competition < ActiveRecord::Base
  belongs_to :user
  has_many :rounds

  validates :name, presence: true
  validates :user, presence: true
  validates :start_date, presence: true
  #   is_a_date?: true
  # validates :end_date, is_a_date?: true
  # validates :state, is_a_state?: true

  # def name
  #   unless gender.nil?
  #     gender_string = ", #{gender}"
  #   else
  #     gender_string = ""
  #   end
  #
  #   unless division.nil?
  #     division_string = ", #{divison}"
  #   else
  #     division_string = ""
  #   end
  #
  #   name + gender_string + divison_string
  # end

  # private
  #
  # def is_a_date?(date)
  #   date.is_a?(Date)
  # end
  #
  # STATES = ['AK', 'AL', 'AR', 'AZ', 'CA', 'CO', 'CT', 'DC', 'DE', 'FL', 'GA',
  #   'HI', 'IA', 'ID', 'IL', 'IN', 'KS', 'KY', 'LA', 'MA', 'MD', 'ME', 'MI',
  #   'MN', 'MO', 'MS', 'MT', 'NC', 'ND', 'NE', 'NH', 'NJ', 'NM', 'NV', 'NY',
  #   'OH', 'OK', 'OR', 'PA', 'RI', 'SC', 'SD', 'TN', 'TX', 'UT', 'VA', 'VT',
  #   'WA', 'WI', 'WV', 'WY']
  #
  # def is_a_state?(state)
  #   STATES.include?(state)
  # end
end
