class Rotowire
  class << self
    def injury_report
      JsonApi::Response.new(
        request(
          'cbasketball/tables/injury-report.php',
          query: payload
        )
      )
    end

    private

    def payload
      {
        team: :ALL,
        pos: :ALL,
        conf: :ALL,
        site: :other,
        slate: :all,
        type: :main
      }
    end

    def request(path, overrides = {})
      payload = {
        path: URI.encode(path)
      }
      client.get(payload.merge(overrides))
    end

    def client
      JsonApi::Client.new(credentials[:host])
    end

    def credentials
      Rails.application.credentials.rotowire
    end
  end
end
