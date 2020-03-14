class Game
  include Mongoid::Document
  field :status
  field :home_points, type: Integer
  field :away_points, type: Integer
  field :favorite, type: Boolean, default: false
  field :played_at, type: Date
  field :scheduled_at
  field :conference_game, type: Boolean, default: false
  field :neutral_site, type: Boolean, default: false
  belongs_to :away_team, class_name: Team, optional: true
  belongs_to :home_team, class_name: Team, optional: true

  def teams
    [away_team, home_team]
  end
end