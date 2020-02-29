class TeamsController < ApplicationController
  before_action :set_team, only: [:last_game]
  def index
    @teams = Team.all.sort_by { |team| team.last_offensive_score }.reverse
  end

  def last_game
    redirect_to game_path(@team.last_game)
  end

  def refresh
    binding.pry
  end

  def update
    binding.pry
  end

  private

  def set_team
    @team = Team.find(params[:id])
  end
end
