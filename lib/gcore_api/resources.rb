module GcoreApi
  class Resources
    def list
      Util.parse_response_body(GcoreApi.client.execute_request(path: '/resources', method: 'GET'))
    end

    def find(resource_id)
      Util.parse_response_body(GcoreApi.client.execute_request(path: "/resources/#{resource_id}", method: 'GET'))
    end
  end
end