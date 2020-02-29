class Ranking
  include Mongoid::Document
  field :offensive_score, type: Float
  field :defensive_score, type: Float
  field :top_rebounders, type: Integer
  field :top_defenders, type: Integer
  field :sloppy_players, type: Integer
  field :top_players, type: Integer
  field :two_point_shooters, type: Integer
  field :three_point_shooters, type: Integer
  field :foul_shooters, type: Integer
  embedded_in :team, class_name: Team
  belongs_to :game
end