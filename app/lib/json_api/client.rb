module JsonApi
  class Client
    attr_reader :host

    def initialize(host)
      @host = host
    end

    def post(request)
      call(:post, request)
    end

    def get(request)
      call(:get, request)
    end

    private

    def call(method, request)
      connection.send(method, request)
    end

    def connection
      Excon.new(host, expects: [200])
    end
  end
end
