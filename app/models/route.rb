class Route < ActiveRecord::Base
  belongs_to :round
  delegate :competition, to: :round

  has_many :attempts
  has_many :highpoints
  has_many :route_ranks
  has_many :athletes, through: :highpoints

  validates :name,
    presence: true,
    uniqueness: { scope: :round }
  validates :round, presence: true
  validates :max_score,
    presence: true,
    numericality: true

  after_save :set_default_attempts_for_route

  def set_default_attempts_for_route
    round.competition.athletes.each do |athlete|
      attempt = attempts.new(athlete: athlete, score: 0)
      attempt.save
      attempt.update_highpoint
    end

    @defaults_set = true
  end

  def leaderboard
    route_ranks.order(:rank)
  end

  def attempts_to_highpoint(athlete)
    athlete_highpoint(athlete).try(:number) || 0
  end

  def athlete_attempts(athlete)
    attempts.where(athlete: athlete).order(:created_at)
  end

  def athlete_highpoint(athlete)
    highpoints.find_by(athlete: athlete)
  end

  def athlete_rank(athlete)
    route_ranks.find_by(athlete: athlete).try(:rank)
  end

  def top?(athlete)
    athlete_highpoint(athlete).try(:top)
  end

  def score(athlete)
    athlete_highpoint(athlete).try(:score) || 0
  end

  def score_display(athlete)
    if top?(athlete)
      "TOP"
    else
      score(athlete)
    end
  end

  def update_ranks
    ties_hash.each do |_, ties|
      rank = determine_route_rank(ties)
      save_ranks(ties, rank)
    end
  end

  def determine_route_rank(ties)
    ties_count = ties.count
    tied_ranks_sum = 0
    ties.each { |_, rank| tied_ranks_sum += rank }
    tied_ranks_sum.to_f / ties_count.to_f
  end

  def save_ranks(ties, rank)
    ties.each do |highpoint, _|
      route_rank = route_ranks.find_or_initialize_by(
        athlete: highpoint.athlete)
      route_rank.rank = rank
      route_rank.highpoint = highpoint
      route_rank.save!
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
    unless @defaults_set == true
      all_highpoints = Highpoint.where(route: self)
    else
      all_highpoints = highpoints
    end
    all_highpoints.sort_by { |a| [-a.score, a.number] }
  end
end
