require 'repository/note_repository'
require 'api/serializers/serializable_note'
require 'api/serializers/serializable_error'

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
        note = NoteRepository.build
                 .by_id(note_id)

        if note
          response.status = 200
          renderer.render(
            note,
            class: { 'ROM::Struct::Note': SerializableNote },
            links: { self: "http://example.org/api/notes/#{note.id}" }
          )
        else
          response.status = 400
          renderer.render_errors(
            [{ status: 400,
               title: 'Invalid id',
               detail: 'Can not find a note with given id',
               source: { parameter: :id } }],
            class: { 'Hash': SerializableError }
          )
        end
      rescue StandardError
        response.status = 400
        renderer.render_errors(
          [{ status: 400,
             title: 'Invalid id',
             detail: 'Can not find a note with given id',
             source: { parameter: :id } }],
          class: { 'Hash': SerializableError }
        )
      end
    end
  end
end
