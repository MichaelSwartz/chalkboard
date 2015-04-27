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
  after_save :update_round_scores

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
        rank.save!
      end
    end
  end

  def update_round_scores
    round.athletes.uniq.each do |athlete|
      round_score = RoundScore.find_or_initialize_by(athlete: athlete, round: round)
      route_count = round.routes.count
      total_score = round.routes.inject(1) do |product, route|
        product * (route.athlete_rank(athlete) || 0)
      end
      round_score.score = (total_score.to_f ** (1 / route_count.to_f)).round(2)
      round_score.tops = round.top_count(athlete)
      round_score.save
    end
  end

  def top?
    score == route.max_score
  end

  def score_display
    if top?
      "TOP"
    else
      score
    end
  end

  def css_class
    if top?
      "top"
    else
      "other"
    end
  end
  # class=<% @route.athlete_highpoint(athlete).css_class %>
end
