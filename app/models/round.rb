class Round < ActiveRecord::Base
  belongs_to :competition
  has_many :routes
  has_many :attempts, through: :routes
  has_many :athletes, through: :attempts

  validates :competition, presence: true
  validates :name, presence: true
  validates :number,
    presence: true,
    numericality: { only_integer: true }

  def leaderboard
    athletes.uniq.sort do |a, b|
      [sends(b), total_score(b), flashes(b), attempts_to_highpoints(a)] <=>
        [sends(a), total_score(a), flashes(a), attempts_to_highpoints(b)]
    end
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

  def flashes(athlete)
    sends = 0
    routes.each do |route|
      sends += 1 if route.flash?(athlete)
    end
    sends
  end

  def attempts_to_highpoints(athlete)
    routes.inject(0) do |sum, route|
      sum + route.attempts_to_highpoint(athlete)
    end
  end
end
