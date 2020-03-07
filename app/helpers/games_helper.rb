module GamesHelper
  def current_game
    @current_game ||= Game.find(params[:id])
  end

  def game_day
    params[:game_day]&.to_date || Date.current
  end

  def date_range
    (4.days.ago.to_date)..(4.days.from_now.to_date)
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
end
