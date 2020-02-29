class GamesController < ApplicationController
  include DictionaryHelper
  helper :dictionary
  include GamesHelper
  helper :games

  def index
    ImportGames.new(game_day).call if todays_games.count.zero?
  end

  def filter
    redirect_to root_path(game_day: game_day, watching: params[:watching])
  end

  def show
  end

  def action
    if params[:commit] == follow_text(current_game)
      current_game.update(favorite: !current_game.favorite?)
    elsif params[:commit] == update_text
      CommitEligibility.new(params[:eligibility]).call
      GenerateRankings.new(current_game).call
    elsif params[:commit] == refresh_text
      refresh_player_stats
      GenerateRankings.new(current_game).call
    end
    redirect_back fallback_location: game_path(current_game)
  end

  private

  def refresh_player_stats
    current_game.teams.each do |team|
      ImportPlayers.new(team).call
    end
  end
end