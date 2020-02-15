class GenerateRankings
  attr_reader :game

  def initialize(game)
    @game = game
  end

  def call
    game.teams.each do |team|
      result = ((((team.eligible_players.count / 5.0) * 100).to_i +
        ((team.shooters_2.count / 5.0) * 100).to_i +
        ((team.shooters_3.count / 5.0) * 100).to_i +
        ((team.shooters_foul.count / 5.0) * 100).to_i) / 400.0) * 100
      team.rankings.where(game_id: game.id).destroy_all
      team.rankings.create(
        game_id: game.id,
        offensive_score: result.round,
        top_players: team.eligible_players.count,
        two_point_shooters: team.shooters_2.count,
        three_point_shooters: team.shooters_3.count,
        foul_shooters: team.shooters_foul.count
      )
    end
  end
end