module JsonApi
  class Response
    delegate :[], to: :body
    delegate :each, to: :body
    attr_reader :response

    def initialize(response)
      @response = response
    end

    def body
      @body ||= JSON.parse(response.body)
    end
  end
end
