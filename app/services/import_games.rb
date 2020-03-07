class ImportGames
  attr_reader :game_day

  def initialize(game_day)
    @game_day = game_day
  end

  def call
    SportsRadar.games(game_day)['games'].each do |game_data|
      game = Game.find_or_create_by(id: game_data['id'])
      game.update!(
        played_at: game_day,
        conference_game: game_data['conference_game'],
        neutral_site: game_data['neutral_site'],
        scheduled_at: game_data['scheduled'].to_time.in_time_zone.strftime("%l:%M%p"),
        away_team: find_or_create_team(game_data['away']),
        home_team: find_or_create_team(game_data['home'])
      )
    end
  end

  private

  def find_or_create_team(team_data)
    return unless team_data['id'].present?
    Team.find_or_create_by(
      id: team_data['id'],
      name: team_data['name']
    )
  end
end