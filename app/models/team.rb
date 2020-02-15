class Team
  include Mongoid::Document
  field :name
  embeds_many :rankings, class_name: Ranking
  embeds_many :players, class_name: Player
  validates :name, presence: true

  def rankings_for(game)
    rankings.where(game_id: game.id).first
  end

  def set_eligibility(player_ids)
    players.update_all(eligible: false)
    players.where(:id.in => player_ids).update_all(eligible: true)
  end

  def top_players
    players.select do |player|
      player.minutes_played >= Settings::MINUTES_PLAYED
    end
  end

  def eligible_players
    top_players.select(&:eligible)
  end

  def shooters_2
    eligible_players.select do |player|
      player.field_goal_percent >= Settings::TWO_POINT_AVERAGE ||
        player.two_point_percent >= Settings::TWO_POINT_AVERAGE
    end
  end

  def shooters_3
    eligible_players.select do |player|
      player.three_point_percent >= Settings::THREE_POINT_AVERAGE
    end
  end

  def shooters_foul
    eligible_players.select do |player|
      player.foul_percent >= Settings::FOUL_AVERAGE
    end
  end
end