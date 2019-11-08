module GcoreApi
  class Util
    class << self
      def parse_response_body(response)
        data = JSON.parse(response.body)
        if data.is_a? Array
          data.map { |e| OpenStruct.new(e) }
        elsif data.is_a? Hash
          OpenStruct.new(data)
        else
          data
        end
      end
    end
  end
end