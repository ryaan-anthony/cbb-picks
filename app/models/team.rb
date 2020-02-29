class Team
  include Mongoid::Document
  field :name
  field :favorite, type: Boolean, default: false
  embeds_many :rankings, class_name: Ranking
  embeds_many :players, class_name: Player
  validates :name, presence: true

  def last_offensive_score
    rankings.last.try(:offensive_score) || 0
  end

  def last_defensive_score
    rankings.last.try(:defensive_score) || 0
  end

  def last_game
    Game.any_of({ away_team_id: id }, { home_team_id: id }).last
  end

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

  def sloppy_players
    eligible_players.select do |player|
      player.turnovers >= Settings::TURNOVER_AVERAGE ||
        player.personal_fouls >= Settings::PERSONAL_FOUL_AVERAGE
    end
  end

  def rebounders
    eligible_players.select do |player|
      player.rebounds >= Settings::REBOUND_AVERAGE
    end
  end

  def defenders
    eligible_players.select do |player|
      player.steals >= Settings::STEAL_AVERAGE ||
        player.blocks >= Settings::BLOCK_AVERAGE
    end
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