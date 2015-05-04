class Bib < ActiveRecord::Base
  belongs_to :competition
  belongs_to :athlete

  validates :competition, presence: true
  validates :athlete, presence: true
  validates :athlete, uniqueness: { scope: :competition }
  validates :number, uniqueness: { scope: :competition },
    allow_nil: true, allow_blank: true

  after_save :set_default_attempts_for_bib

  def set_default_attempts_for_bib
    competition.routes.each do |route|
      athlete.attempts.create(route: route, score: 0)
    end
  end
end
