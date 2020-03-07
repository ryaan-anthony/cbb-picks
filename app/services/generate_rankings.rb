class GenerateRankings
  attr_reader :game

  def initialize(game)
    @game = game
  end

  def call
    game.teams.each do |team|
      team.rankings.where(game_id: game.id).destroy_all
      team.rankings.create(
        game_id: game.id,
        offensive_score: offensive_score(team).round,
        defensive_score: defensive_score(team).round,
        sloppy_players: team.sloppy_players.count,
        top_rebounders: team.rebounders.count,
        top_defenders: team.defenders.count,
        top_players: team.eligible_players.count,
        two_point_shooters: team.shooters_2.count,
        three_point_shooters: team.shooters_3.count,
        foul_shooters: team.shooters_foul.count
      )
    end
  end

  private

  def defensive_score(team)
    (((100 - ((team.sloppy_players.count / 5.0) * 100).to_i) +
      ((team.defenders.count / 5.0) * 100).to_i +
      ((team.rebounders.count / 5.0) * 100).to_i) / 300.0) * 100
  end

  def offensive_score(team)
    ((((team.shooters_2.count / 5.0) * 100).to_i +
      ((team.shooters_3.count / 5.0) * 100).to_i +
      ((team.shooters_foul.count / 5.0) * 100).to_i) / 300.0) * 100
  end
end