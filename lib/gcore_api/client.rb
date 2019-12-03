require 'active_support'

module GcoreApi
  class Client
    attr_reader :headers, :access_token, :refresh_token

    def initialize
      load_tokens
      self.headers = {}
    end

    METHODS = %w[GET POST PATCH PUT DELETE].freeze
    def execute_request(path:, method:, body: nil, query: nil)
      raise ArgumentError, "Only #{METHODS.join(',')} are allowed" unless METHODS.include?(method.to_s.upcase)

      response = send_request(method.to_s.upcase, path, body, query)
      return response unless response.code == 401

      authenticate
      logger.debug 'Try authenticate request'
      logger.debug response
      send_request(method.to_s.upcase, path, body, query)
    end

    private

    def authenticate
      if headers.present?
        response = send_request('GET', '/clients/me', nil, nil)
        refresh_tokens if response.code == 401

        return
      end

      unless tokens_exists?
        response = send_request('POST', '/auth/jwt/login', { username: GcoreApi.username, password: GcoreApi.password }, nil)
        raise AuthenticateError.new(response), 'Authenticate data is invalid' unless response.code == 200

        save_tokens(JSON.parse(response.body))
      end
      self.headers = { 'Authorization' => "Bearer #{access_token}" }
      response = send_request('GET', '/clients/me', nil, nil)
      refresh_tokens if response.code == 401
    end

    def send_request(method, path, body, query)
      connection = Typhoeus::Request.new("#{GcoreApi.api_base}#{path}",
                                         followlocation: true, headers: headers,
                                         body: body.to_json, params: query, method: method)

      logger.debug "Request #{method} #{path}"
      logger.debug "Response body #{body}" if body.present?
      connection.run
    end

    def refresh_tokens
      logger.debug 'refresh'
      response = send_request('POST', '/auth/jwt/refresh', { refresh: refresh_token }, nil)
      unless response.success?
        response = send_request('POST', '/auth/jwt/login', { username: GcoreApi.username, password: GcoreApi.password }, nil)
      end
      raise AuthenticateError.new(response), 'Authenticate data is invalid' unless response.code == 200

      save_tokens(JSON.parse(response.body))
      self.headers = { 'Authorization' => "Bearer #{access_token}" }
    end

    def save_tokens(response)
      @access_token = response['access']
      @refresh_token = response['refresh']
      data = { access_token: access_token, refresh_token: refresh_token }
      encryptor = ActiveSupport::MessageEncryptor.new(GcoreApi.secret_key[0..31])
      encrypted_data = encryptor.encrypt_and_sign(data.to_json)
      file = File.open(GcoreApi.tokens_file_name, 'w')
      file.write(encrypted_data)
      file.close
    end

    def load_tokens
      return unless File.file?(GcoreApi.tokens_file_name)

      file = File.open(GcoreApi.tokens_file_name, 'r')
      encrypted_data = file.read
      encryptor = ActiveSupport::MessageEncryptor.new(GcoreApi.secret_key[0..31])
      decrypted_data = encryptor.decrypt_and_verify(encrypted_data)
      tokens = JSON.parse(decrypted_data)
      @access_token = tokens['access_token']
      @refresh_token = tokens['refresh_token']
      self.headers = { 'Authorization' => "Bearer #{access_token}" }
      file.close
    end

    def tokens_exists?
      @access_token.present? && @refresh_token.present?
    end

    def logger
      GcoreApi.logger
    end

    def headers=(val)
      @headers ||= { 'Content-Type': 'application/json' }
      @headers.merge!(val)
    end
  end
end