module GcoreApi
  class Util
    class << self
      def parse_response_body(response)
        OpenStruct.new(JSON.parse(response.body))
      end
    end
  end
end