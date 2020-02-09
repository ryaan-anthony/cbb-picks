module GamesHelper
  def current_game
    @current_game ||= Game.find(params[:game_id])
  end

  def game_day
    params[:game_day] || Date.current
  end

  def date_range
    (2.days.ago.to_date)..(2.days.from_now.to_date)
  end

  def todays_games
    @todays_games ||= Game.where(played_at: game_day)
  end
end
