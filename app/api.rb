class API < Roda
  route do |request|
    request.get do
      response.status = 200
      'Api is working'.to_json
    end
  end
end
