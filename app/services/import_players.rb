class ImportPlayers
  attr_reader :team

  def initialize(team)
    @team = team
  end

  def call
    team.players.destroy_all
    SportsRadar.team(team.id)['players'].each do |player|
      team.players.create(
        name: player['full_name'],
        minutes_played: player['average']['minutes'],
        points_per_game: player['average']['points'],
        field_goal_percent: player['total']['field_goals_pct'],
        two_point_percent: player['total']['two_points_pct'],
        three_point_percent: player['total']['three_points_pct'],
        foul_percent: player['total']['free_throws_pct']
      )
    end
  end
end