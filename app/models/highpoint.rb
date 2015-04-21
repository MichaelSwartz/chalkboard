class Highpoint < ActiveRecord::Base
  belongs_to :attempt
  belongs_to :athlete
  belongs_to :route
  has_one :route_rank

  delegate :score, to: :attempt, allow_nil: true
  delegate :number, to: :attempt, allow_nil: true
  delegate :round, to: :route
  delegate :css_class, to: :attempt

  validates :attempt, presence: true
  validates :athlete, presence: true
  validates :route, presence: true

  after_save :update_route_leaderboard

  def update_route_leaderboard
    hash = {}
    highpoints = route.highpoints.sort_by { |a| [-a.score, a.number] }
    highpoints.each_with_index do |highpoint, i|
      hash[[highpoint.score, highpoint.number]] ||= []
      hash[[highpoint.score, highpoint.number]] << [highpoint, i + 1]
    end
    hash.each do |_, array|
      ties_count = array.count
      total_ranks = array.inject(0) { |sum, inner_array| sum + inner_array[1] }
      route_rank = total_ranks.to_f / ties_count.to_f
      array.each do |inner_array|
        rank = RouteRank.find_or_initialize_by(athlete: inner_array[0].athlete, route: route)
        rank.rank = route_rank
        rank.highpoint = inner_array[0]
        rank.save
      end
    end
  end

  def send?
    score == route.max_score
  end

  def score_display
    if send?
      "TOP"
    else
      score
    end
  end

  def css_class
    if send?
      "send"
    else
      "other"
    end
  end
  # class=<% @route.athlete_highpoint(athlete).css_class %>
end
