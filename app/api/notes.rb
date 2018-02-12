require 'repository/note_repository'
require 'api/serializers/serializable_note'

class API::Notes < Roda
  plugin :json
  plugin :json_parser

  def renderer
    JSONAPI::Serializable::Renderer.new
  end

  route do |request|
    request.is do
      request.get do
        response.status = 200

        notes = NoteRepository.build.all

        renderer.render(
          notes,
          class: { 'ROM::Struct::Note': SerializableNote },
          meta: { count: notes.size },
          links: { self: request.url }
        )
      end

      request.post do
        response.status = 201
        note = NoteRepository.build
                 .create(text: request.params['text'])

        renderer.render(
          note,
          class: { 'ROM::Struct::Note': SerializableNote },
          links: { self: 'http://example.org/api/notes' }
        )
      end
    end

    request.on(:id) do |note_id|
      request.get do
        response.status = 200

        note = NoteRepository.build
                 .by_id(note_id)

        renderer.render(
          note,
          class: { 'ROM::Struct::Note': SerializableNote },
          links: { self: "http://example.org/api/notes/#{note.id}" }
        )
      end
    end
  end
end
