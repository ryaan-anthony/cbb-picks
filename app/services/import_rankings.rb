class ImportRankings
  def call
    Team.all.each do |team|
      team.rankings.each do |ranking|
        ranking.delete unless ranking.valid?
      end
    end

    SportsRadar.rankings['rankings'].each do |team_data|
      team = Team.find(team_data['id'])
      team.opponents = []
      team.update(
        name: team_data['name'],
        market: team_data['market'],
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

    Team.by_rank.each_with_index do |team, index|
      team.update(r_rank: index + 1)
    end

    Team.all.each do |team|
      team.injuries.destroy_all
    end

    Rotowire.injury_report.each do |injury_data|
      team = Team.where(market: injury_data['team']).first
      next if team.nil?
      team.injuries.create(
        player: injury_data['player'],
        injury: injury_data['injury'],
        status: injury_data['status']
      )
    end
  end
end