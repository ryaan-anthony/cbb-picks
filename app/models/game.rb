class Game
  include Mongoid::Document
  field :played_at, type: Date
  belongs_to :away_team, class_name: Team
  belongs_to :home_team, class_name: Team
  validates :away_team, presence: true
  validates :home_team, presence: true
end