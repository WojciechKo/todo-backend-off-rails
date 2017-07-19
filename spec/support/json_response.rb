require 'json'

module JsonResponse
  def json_response
    ::JSON.parse(last_response.body)
  end
end
