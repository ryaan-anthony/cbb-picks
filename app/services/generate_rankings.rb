class GenerateRankings
  MINUTES_PLAYED = 17.0
  THREE_POINT_AVERAGE = 0.4
  TWO_POINT_AVERAGE = 0.5
  FOUL_AVERAGE = 0.7
  attr_reader :game, :team

  def initialize(team, game)
    @team = team
    @game = game
  end

  def call
    shooters_2 = top_players.select { |player| player.field_goal_percent >= TWO_POINT_AVERAGE || player.two_point_percent >= TWO_POINT_AVERAGE }
    shooters_3 = top_players.select { |player| player.three_point_percent >= THREE_POINT_AVERAGE }
    shooters_foul = top_players.select { |player| player.foul_percent >= FOUL_AVERAGE }
    result = ((((top_players.count / 5.0) * 100).to_i +
      ((shooters_2.count / 5.0) * 100).to_i +
      ((shooters_3.count / 5.0) * 100).to_i +
      ((shooters_foul.count / 5.0) * 100).to_i) / 400.0) * 100

    team.rankings.create(
       game_id: game.id,
       offensive_score: result.round,
       top_players: top_players.count,
       two_point_shooters: shooters_2.count,
       three_point_shooters: shooters_3.count,
       foul_shooters: shooters_foul.count
    )
  end

  def top_players
    @top_players ||= team.players.active.select { |player| player.minutes_played >= MINUTES_PLAYED }
  end
end