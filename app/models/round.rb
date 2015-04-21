class Round < ActiveRecord::Base
  belongs_to :competition
  has_many :routes
  has_many :attempts, through: :routes
  has_many :athletes, through: :attempts

  # delegate :athletes, to: :competition

  validates :competition, presence: true
  validates :name, presence: true
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
    athletes.uniq.sort_by do |a|
      [-sends(a), -total_score(a), -flashes(a), attempts_to_highpoints(a)]
    end
  end

  # def subsequent_round_leaderboard
  #   athletes.uniq.sort_by do |a|
  #     [-sends(a), -total_score(a), -flashes(a), attempts_to_highpoints(a), previous_round.standings[a]]
  #   end
  # end

  def standings
    standings = {}
    leaderboard.each_with_index do |athlete, index|
      standings[athlete] = index + 1
    end
    standings
  end

  def single_route?
    routes.count == 1
  end

  def first_round?
    previous_round.nil?
  end

  def previous_round
    competition.rounds.find_by(number: (number - 1))
  end

  def sends(athlete)
    sends = 0
    routes.each do |route|
      sends += 1 if route.send?(athlete)
    end
    sends
  end

  def total_score(athlete)
    routes.inject(0) do |sum, route|
      sum + route.score(athlete)
    end
  end


  def attempts_to_highpoints(athlete)
    routes.inject(0) do |sum, route|
      sum + route.attempts_to_highpoint(athlete)
    end
  end
end
