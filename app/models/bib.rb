class Bib < ActiveRecord::Base
  belongs_to :competition
  belongs_to :athlete

  validates :competition, presence: true
  validates :athlete, presence: true
  validates :athlete, uniqueness: {scope: :competition}
  validates :number, uniqueness: {scope: :competition}, allow_nil: true
end
