class API
  class Notes < Roda
    plugin :json
    plugin :json_parser

    route do |request|
      request.is do
        request.get do
          response.status = 200

          {
            _links: {
              self: { href: "#{request.base_url}#{request.path}" }
            },
            count: 1,
            _embedded: {
              notes: [
                {
                  _links: {
                    self: { href: 'http://example.org/api/notes/1' }
                  },
                  id: 1,
                  text: 'Simple note'
                }
              ]
            }
          }
        end

        request.post do
          response.status = 201

          {
            _links: {
              self: { href: 'http://example.org/api/notes/1' }
            },
            id: 1,
            text: request.params['text']
          }
        end
      end

      request.on(:id) do
        request.get do
          response.status = 200

          {
            _links: {
              self: { href: 'http://example.org/api/notes/1' }
            },
            id: 1,
            text: 'Simple note'
          }
        end
      end
    end
  end
end
