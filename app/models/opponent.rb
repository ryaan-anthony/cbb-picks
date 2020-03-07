class Opponent
  include Mongoid::Document
  embedded_in :team, class_name: Team
  field :rank
  field :wins, type: Integer
  field :losses, type: Integer

  def win_percent
    wins.to_f / (wins.to_f + losses.to_f)
  end

  def win_percent?
    win_percent >= Settings::WIN_PERCENT
  end
end