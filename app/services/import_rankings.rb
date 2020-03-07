class ImportRankings
  def call
    SportsRadar.rankings['rankings'].each do |team_data|
      team = Team.find(team_data['id'])
      team.opponents = []
      team.update(
        rank: team_data['rank'],
        wins: team_data['wins'],
        losses: team_data['losses'],
        home_wins: team_data['home_wins'],
        home_losses: team_data['home_losses'],
        away_wins: team_data['away_wins'],
        away_losses: team_data['away_losses'],
        neut_wins: team_data['neut_wins'],
        neut_losses: team_data['neut_losses'],
        opponents_attributes: team_data['opponents'][0..3]
      )
    end
    SportsRadar.ap_rankings['rankings'].each do |team_data|
      team = Team.find(team_data['id'])
      team.update(ap_rank: team_data['rank'])
    end
  end
end