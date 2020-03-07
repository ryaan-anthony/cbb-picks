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
  field :height, type: Integer
  field :weight, type: Integer
  field :experience
  embedded_in :team, class_name: Team
  scope :eligible, -> { where(eligible: true) }

  def ft_height
    "#{height / 12}' #{height % 12}\"" rescue nil
  end

  def big_boy?
    weight >= 220 rescue false
  end

  def tall?
    height >= 78 rescue false
  end

  def defender?
    steals? || blocks?
  end

  def shooter_2?
    field_goal_percent? || two_point_percent?
  end

  def field_goal_percent?
    field_goal_percent >= Settings::TWO_POINT_AVERAGE
  end

  def two_point_percent?
    two_point_percent >= Settings::TWO_POINT_AVERAGE
  end

  def three_point_percent?
    three_point_percent >= Settings::THREE_POINT_AVERAGE
  end

  def blocks?
    blocks >= Settings::BLOCK_AVERAGE
  end

  def steals?
    steals >= Settings::STEAL_AVERAGE
  end

  def rebounder?
    rebounds >= Settings::REBOUND_AVERAGE
  end
end