require 'repository/note_repository'

class API
  class Notes < Roda
    plugin :json
    plugin :json_parser

    route do |request|
      request.is do
        request.get do
          response.status = 200

          notes = NoteRepository.build
                    .all.map do |note|
            {
              _links: {
                self: { href: "http://example.org/api/notes/#{note.id}" }
              },
              id: note.id,
              text: note.text
            }
          end

          {
            _links: {
              self: { href: "#{request.base_url}#{request.path}" }
            },
            count: notes.size,
            _embedded: {
              notes: notes
            }
          }
        end

        request.post do
          response.status = 201
          note = NoteRepository.build
                   .create(text: request.params['text'])

          {
            _links: {
              self: { href: "http://example.org/api/notes/#{note.id}" }
            },
            id: note.id,
            text: note.text
          }
        end
      end

      request.on(:id) do
        request.get do
          response.status = 200

          note = NoteRepository.build
                   .by_id(request.params['id'])

          {
            _links: {
              self: { href: "http://example.org/api/notes/#{note.id}" }
            },
            id: note.id,
            text: note.text
          }
        end
      end
    end
  end
end
