class GamesController < ApplicationController
  include GamesHelper
  helper :games

  def index
  end

  def show
  end

  def import
    ImportGames.new(game_day).call if todays_games.count.zero?
    redirect_to root_path(game_day: game_day)
  end
end