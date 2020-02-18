class ParlayController < ApplicationController
  before_action :fetch_parlay
  helper :parlay

  def index
  end

  def create
    @parlay.update(
      num_teams:          params.require(:num_teams),
      top_teams:          params.require(:top_teams).split("\n"),
      max_occurrences:    params.require(:max_occurrences),
      middle_teams:       params.require(:middle_teams).split("\n"),
      middle_occurrences: params.require(:middle_occurrences),
      bottom_teams:       params.require(:bottom_teams).split("\n"),
      bottom_occurrences: params.require(:bottom_occurrences)
    )
    redirect_to parlay_index_path
  end

  private

  def fetch_parlay
    @parlay = Parlay.first_or_initialize
  end
end

