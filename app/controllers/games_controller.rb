class GamesController < ApplicationController
  include GamesHelper
  helper :games

  def index
    ImportGames.new(game_day).call if todays_games.count.zero?
  end

  def show
    current_game.teams.each do |team|
      unless team.rankings_for(current_game)
        ImportPlayers.new(team).call
        GenerateRankings.new(team, current_game).call
      end
    end
  end

  def favorite
    current_game.update(favorite: !!!current_game.favorite?)
    redirect_back fallback_location: game_path(current_game)
  end

  def filter
    redirect_to root_path(game_day: game_day, watching: params[:watching])
  end
end