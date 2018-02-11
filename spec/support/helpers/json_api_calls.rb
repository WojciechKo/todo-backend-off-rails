require 'json'
require 'rack/test'

module JsonApiCalls
  class JsonResponse < SimpleDelegator
    def json
      JSON.parse(body)
    end
  end

  include Rack::Test::Methods

  HTTP_VERBS = %i[get post put patch delete options head].freeze

  # Override Rack::Test methods so that each request will be send as application/json
  # Example:
  # get '/notes', params: {type: 'in_progress'}, headers: {'Auth-Token' => 'abcd123'}
  HTTP_VERBS.each do |http_verb|
    define_method(http_verb) do |uri, params: {}, headers: {}, &block|
      env = headers.each_with_object({}) do |(key, value), result|
        env_key = key.upcase.tr('-', '_')
        env_key = 'HTTP_' + env_key unless env_key == 'CONTENT_TYPE'
        result[env_key] = value
      end
      env['CONTENT_TYPE'] = 'application/json'

      super(uri, params.to_json, env, &block)
      last_response
    end
  end

  def last_response
    JsonResponse.new(super)
  end
end
