class Opponent
  include Mongoid::Document
  embedded_in :team, class_name: Team
  field :rank
  field :wins, type: Integer
  field :losses, type: Integer
end