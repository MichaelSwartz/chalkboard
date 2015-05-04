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
    ties_hash.each do |_, ties|
      route_rank = determine_route_rank(ties)
      save_ranks(ties, route_rank)
    end

    update_round_scores
  end

  def determine_route_rank(ties)
    ties_count = ties.count
    tied_ranks_sum = 0
    ties.each { |_, rank| tied_ranks_sum += rank }
    tied_ranks_sum.to_f / ties_count.to_f
  end

  def save_ranks(ties, route_rank)
    ties.each do |highpoint, _|
      rank = RouteRank.find_or_initialize_by(
        athlete: highpoint.athlete, route: route)
      rank.rank = route_rank
      rank.highpoint = highpoint
      rank.save!
    end
  end

  def ties_hash
    ties = {}
    highpoints = sort_highpoints

    highpoints.each_with_index do |highpoint, i|
      ties[[highpoint.score, highpoint.number]] ||= {}
      ties[[highpoint.score, highpoint.number]][highpoint] = i + 1
    end
    ties
  end

  def sort_highpoints
    route.highpoints.sort_by { |a| [-a.score, a.number] }
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
