class ImportPlayers
  attr_reader :team

  def initialize(team)
    @team = team
  end

  def call
    SportsRadar.team_statistics(team.id)['players'].each do |player_data|
      player = team.players.find_or_create_by(id: player_data['id'])
      player.update(
        name: player_data['full_name'],
        minutes_played: player_data['average']['minutes'],
        points_per_game: player_data['average']['points'],
        field_goal_percent: player_data['total']['field_goals_pct'],
        two_point_percent: player_data['total']['two_points_pct'],
        three_point_percent: player_data['total']['three_points_pct'],
        foul_percent: player_data['total']['free_throws_pct'],
        rebounds: player_data['average']['rebounds'],
        steals: player_data['average']['steals'],
        blocks: player_data['average']['blocks'],
        turnovers: player_data['average']['turnovers'],
        personal_fouls: player_data['average']['personal_fouls']
      )
    end
    return if team.players.first.height.present?
    SportsRadar.team_profile(team.id)['players'].each do |player_data|
      player = team.players.find(player_data['id'])
      player.update(
        height: player_data['height'],
        weight: player_data['weight'],
        experience: player_data['experience']
      )
    end
  end
end