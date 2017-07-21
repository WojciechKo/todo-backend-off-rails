class API < Roda
  require_relative 'api/notes'

  route do |req|
    req.is do
      req.get do
        response.status = 200
        response['Content-Type'] = 'application/json'
        '"Api is working"'
      end
    end

    req.on 'notes' do
      req.run API::Notes
    end
  end
end
