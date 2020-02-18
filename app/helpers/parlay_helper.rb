module GamesHelper
  def current_game
    @current_game ||= Game.find(params[:id])
  end

  def game_day
    params[:game_day]&.to_date || Date.current
  end

  def date_range
    (2.days.ago.to_date)..(2.days.from_now.to_date)
  end

  def todays_games
    @todays_games ||= Game.where(played_at: game_day)
  end

  def filtered_games
    favorite_games || todays_games
  end

  def favorite_games
    todays_games.where(favorite: true) if params[:watching] == '1'
  end

  def follow_text(game = current_game)
    game.favorite? ? 'Unfollow' : 'Follow'
  end

  def refresh_text
    'Refresh'
  end

  def update_text
    'Update'
  end
end
