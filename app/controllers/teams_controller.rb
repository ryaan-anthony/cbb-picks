class TeamsController < ApplicationController
  before_action :set_team, only: [:last_game]
  def index
    @teams = Team.by_rank
  end

  def last_game
    redirect_to game_path(@team.last_game)
  end

  def refresh
    ImportRankings.new.call
    redirect_to teams_path
  end

  def update
    binding.pry
  end

  private

  def set_team
    @team = Team.find(params[:id])
  end
end
