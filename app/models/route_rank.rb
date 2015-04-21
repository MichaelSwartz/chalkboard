class RouteRank < ActiveRecord::Base
  belongs_to :athlete
  belongs_to :route
  belongs_to :highpoint

  delegate :round, to: :route
  delegate :score_display, to: :highpoint
  delegate :number, to: :highpoint

  validates :rank,
    presence: true,
    numericality: true
  validates :athlete, presence: true
  validates :route, presence: true

  # after_save :update_route_leaderboard
end
