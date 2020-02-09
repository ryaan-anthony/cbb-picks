class SportsRadar
  class << self
    def games(date = Date.current)
      today = date.in_time_zone('Eastern Time (US & Canada)')
      date_format = "#{today.year}/#{today.month}/#{today.day}"
      JsonApi::Response.new(
        request("ncaamb/trial/v7/en/games/#{date_format}/schedule.json")
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
