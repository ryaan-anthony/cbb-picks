class Player
  include Mongoid::Document
  field :name
  field :eligible, type: Boolean, default: true
  field :minutes_played, type: Float
  field :points_per_game, type: Float
  field :field_goal_percent, type: Float
  field :two_point_percent, type: Float
  field :three_point_percent, type: Float
  field :foul_percent, type: Float
  field :rebounds, type: Float
  field :steals, type: Float
  field :blocks, type: Float
  field :turnovers, type: Float
  field :personal_fouls, type: Float
  embedded_in :team, class_name: Team
  scope :eligible, -> { where(eligible: true) }
end