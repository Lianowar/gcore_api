module GcoreApi
  class Users
    def list
      Util.parse_response_body(GcoreApi.client.execute_request(path: '/users', method: 'GET'))
    end

    def me
      Util.parse_response_body(GcoreApi.client.execute_request(path: '/clients/me', method: 'GET'))
    end

    def find(user_id)
      Util.parse_response_body(GcoreApi.client.execute_request(path: "/users/#{user_id}", method: 'GET'))
    end
  end
end