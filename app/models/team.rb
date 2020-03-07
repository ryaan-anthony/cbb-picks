class Team
  include Mongoid::Document
  field :name
  field :rank, type: Integer, default: 0
  field :ap_rank, type: Integer
  field :wins, type: Integer
  field :losses, type: Integer
  field :home_wins, type: Integer
  field :home_losses, type: Integer
  field :away_wins, type: Integer
  field :away_losses, type: Integer
  field :neut_wins, type: Integer
  field :neut_losses, type: Integer
  embeds_many :rankings, class_name: Ranking
  embeds_many :players, class_name: Player
  embeds_many :opponents, class_name: Opponent
  validates :name, presence: true
  accepts_nested_attributes_for :opponents

  def ranked?
    rank > 0 && rank <= 70
  end

  def hot?
    last_offensive_score >= 70 || last_defensive_score >= 70
  end

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

  def win_percent
    wins.to_f / (wins.to_f + losses.to_f)
  end

  def home_win_percent
    home_wins.to_f / (home_wins.to_f + home_losses.to_f)
  end

  def away_win_percent
    away_wins.to_f / (away_wins.to_f + away_losses.to_f)
  end

  def neut_win_percent
    neut_wins.to_f / (neut_wins.to_f + neut_losses.to_f)
  end

  def win_percent?
    win_percent >= Settings::WIN_PERCENT
  end

  def home_win_percent?
    home_win_percent >= Settings::HOME_WIN_PERCENT
  end

  def away_win_percent?
    away_win_percent >= Settings::AWAY_WIN_PERCENT
  end

  def neut_win_percent?
    neut_win_percent >= Settings::NEUT_WIN_PERCENT
  end

  def set_eligibility(player_ids)
    players.update_all(eligible: false)
    players.where(:id.in => player_ids).update_all(eligible: true)
  end

  def top_players_by_experience
    top_players.sort_by do |player|
      Settings::EXPERIENCES.index(player.experience)
    end
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