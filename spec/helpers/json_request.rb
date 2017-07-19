require 'rack/test'

module JsonRequest
  include Rack::Test::Methods

  HTTP_VERBS = [:get, :post, :put, :patch, :delete, :options, :head].freeze

  # Override Rack::Test methods so that each request will be send as application/json
  # Example:
  # get '/notes', params: {type: 'in_progress'}, headers: {'Auth-Token' => 'abcd123'}
  HTTP_VERBS.each do |http_verb|
    define_method(http_verb) do |uri, params: {}, headers: {}, &block|

      env = headers.each_with_object({}) do |(key, value), result|
        env_key = key.upcase.gsub('-', '_')
        env_key = 'HTTP_' + env_key unless 'CONTENT_TYPE' == env_key
        result[env_key] = value
      end
      env.merge!({ 'CONTENT_TYPE' => 'application/json' })

      super(uri, params.to_json, env, &block)
    end
  end
end
