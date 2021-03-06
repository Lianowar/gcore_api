module GcoreApi
  class Rules
    class << self
      def list(resource_id)
        Util.parse_response_body(GcoreApi.client.execute_request(path: "/resources/#{resource_id}/rules", method: 'GET'))
      end

      def find(resource_id, rule_id)
        Util.parse_response_body(GcoreApi.client.execute_request(path: "/resources/#{resource_id}/rules/#{rule_id}", method: 'GET'))
      end

      def create(resource_id, params)
        Util.parse_response_body(GcoreApi.client.execute_request(path: "/resources/#{resource_id}/rules", method: 'POST', body: params))
      end

      def update(resource_id, rule_id, params)
        Util.parse_response_body(GcoreApi.client.execute_request(path: "/resources/#{resource_id}/rules/#{rule_id}", method: 'PUT', body: params))
      end
    end
  end
end