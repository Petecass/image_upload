module Request
  module JsonHelpers
    def json_response
      @json_response || JSON.parse(last_response.body, symbolize_names: true)
    end
  end
end
