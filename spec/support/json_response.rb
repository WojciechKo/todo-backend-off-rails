require 'json'

module JsonResponse
  def last_response_json
    ::JSON.parse(last_response.body)
  end
end
