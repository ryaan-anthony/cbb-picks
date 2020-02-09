class Game
  include Mongoid::Document
  field :favorite, type: Boolean, default: false
  field :played_at, type: Date
  field :scheduled_at
  belongs_to :away_team, class_name: Team
  belongs_to :home_team, class_name: Team
  validates :away_team, presence: true
  validates :home_team, presence: true

  def teams
    [away_team, home_team]
  end
end