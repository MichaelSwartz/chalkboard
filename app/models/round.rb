class Round < ActiveRecord::Base
  belongs_to :competition
  has_many :routes
  has_many :attempts, through: :routes
  has_many :athletes, through: :attempts
  has_many :round_scores

  validates :competition, presence: true
  validates :name,
    presence: true,
    uniqueness: { scope: :competition }
  validates :number,
    presence: true,
    numericality: { only_integer: true }

  def leaderboard
    first_round_leaderboard
    #
    #
    # if first_round?
    #   first_round_leaderboard
    # else
    #   subsequent_round_leaderboard
    # end
  end

  def first_round_leaderboard
    round_scores.order(tops: :desc, score: :asc)
  end

  # def subsequent_round_leaderboard
  #   round_scores.order(tops: :desc, score: :asc)
  #
  #   athletes.uniq.sort_by do |a|
  #     [-tops(a), -total_score(a), -flashes(a), attempts_to_highpoints(a), previous_round.standings[a]]
  #   end
  # end

  # def standings
  #   standings = {}
  #   leaderboard.each_with_index do |athlete, index|
  #     standings[athlete] = index + 1
  #   end
  #   standings
  # end

  def single_route?
    routes.count == 1
  end

  def first_round?
    previous_round.nil?
  end

  def previous_round
    competition.rounds.find_by(number: (number - 1))
  end

  def top_count(athlete)
    tops = 0
    routes.each do |route|
      tops += 1 if route.top?(athlete)
    end
    tops
  end

  def round_score(athlete)
    round_scores.find_by(athlete: athlete).try(:score)
  end

  def round_tops(athlete)
    round_scores.find_by(athlete: athlete).try(:tops)
  end
end
