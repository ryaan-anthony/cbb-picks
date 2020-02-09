class ImportGames
  attr_reader :game_day

  def initialize(game_day)
    @game_day = game_day
  end

  def call
    SportsRadar.games(game_day)['games'].each do |game|
      Game.find_or_create_by!(
        played_at: game_day,
        scheduled_at: game['scheduled'].to_time.in_time_zone.strftime("%l:%M%p"),
        away_team: find_or_create_team(game['away']),
        home_team: find_or_create_team(game['home'])
      )
    end
  end

  private

  def find_or_create_team(team_data)
    Team.find_or_create_by(
      id: team_data['id'],
      name: team_data['name']
    )
  end
end