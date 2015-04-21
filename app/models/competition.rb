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

  def leaderboard
    final_round.leaderboard
  end

  def final_round
    rounds.order(:number).last
  end

  STATES = ['AK', 'AL', 'AR', 'AZ', 'CA', 'CO', 'CT', 'DC', 'DE', 'FL', 'GA',
            'HI', 'IA', 'ID', 'IL', 'IN', 'KS', 'KY', 'LA', 'MA', 'MD', 'ME',
            'MI', 'MN', 'MO', 'MS', 'MT', 'NC', 'ND', 'NE', 'NH', 'NJ', 'NM',
            'NV', 'NY', 'OH', 'OK', 'OR', 'PA', 'RI', 'SC', 'SD', 'TN', 'TX',
            'UT', 'VA', 'VT', 'WA', 'WI', 'WV', 'WY']

  # def ordered_rounds
  #   rounds.order(:number)
  # end

#   def first_round
#     ordered_rounds.first
#   end
#
#   def previous_round(round)
#     ordered_rounds[round_index(round) - 1]
#   end
#
#   def round_index(round)
#     ordered_rounds.index(round)
#   end
end
