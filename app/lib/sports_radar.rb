class SportsRadar
  class << self
    def game_results
      sleep(1.1) # trial api limits
      year = '2019'
      season = 'REG' # Conference Tournament (CT), Regular Season (REG), or Postseason (PST).
      JsonApi::Response.new(
        request("ncaamb/trial/v7/en/games/#{year}/#{season}/schedule.json")
      )
    end

    def games(date = Date.current)
      sleep(1.1) # trial api limits
      JsonApi::Response.new(
        request("ncaamb/trial/v7/en/games/#{date.year}/#{date.month}/#{date.day}/schedule.json")
      )
    end

    def rankings
      sleep(1.1) # trial api limits
      year = '2019'
      JsonApi::Response.new(
        request("ncaamb/trial/v7/en/rpi/#{year}/rankings.json")
      )
    end

    def ap_rankings
      sleep(1.1) # trial api limits
      year = '2019'
      source = 'AP' # AP or US
      JsonApi::Response.new(
        request("ncaamb/trial/v7/en/polls/#{source}/#{year}/rankings.json")
      )
    end

    def team_statistics(team_id)
      sleep(1.1) # trial api limits
      year = '2019'
      season = 'REG' # Conference Tournament (CT), Regular Season (REG), or Postseason (PST).
      JsonApi::Response.new(
        request("ncaamb/trial/v7/en/seasons/#{year}/#{season}/teams/#{team_id}/statistics.json")
      )
    end

    def team_profile(team_id)
      sleep(1.1) # trial api limits
      JsonApi::Response.new(
        request("ncaamb/trial/v7/en/teams/#{team_id}/profile.json")
      )
    end

    private

    def request(path, overrides = {})
      payload = {
        path: URI.encode(path),
        query: { api_key: credentials[:api_key] }
      }
      client.get(payload.merge(overrides))
    end

    def client
      JsonApi::Client.new(credentials[:host])
    end

    def credentials
      Rails.application.credentials.sports_radar
    end
  end
end
