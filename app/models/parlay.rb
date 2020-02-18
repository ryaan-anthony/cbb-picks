class Parlay
  include Mongoid::Document
  field :num_teams, type: Integer, default: 2
  field :max_occurrences, type: Integer, default: 3
  field :middle_occurrences, type: Integer, default: 2
  field :bottom_occurrences, type: Integer, default: 1
  field :top_teams, type: Array, default: []
  field :middle_teams, type: Array, default: []
  field :bottom_teams, type: Array, default: []

  def picks
    top_teams + middle_teams + bottom_teams
  end
end
