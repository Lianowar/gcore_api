module GcoreApi
  class GcoreApiError < StandardError
    attr_reader :message
    attr_reader :code
    attr_reader :body

    def initialize(response)
      parse_error(response)
    end

    private

    def parse_error(response)
      @code = response.code
      @body = response.body
      @message = parse_message(@body) if @body.present?
    end

    def parse_message(body)
      data = JSON.parse(body)
      if data['errors'].present? || data['error'].present?
        data['errors'] || data['error']
      else
        data['message']
      end
    end
  end

  class AuthenticateError < GcoreApiError; end
end