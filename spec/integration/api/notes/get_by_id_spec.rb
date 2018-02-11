require_relative 'helpers'

RSpec.describe 'GET /api/notes/{:id}' do
  context 'note not found' do
    xit 'returns error' do
      get '/api/notes/1'
    end
  end

  context 'note found' do
    let!(:note) { NoteApi.create_note(note_text)['data'] }
    let(:note_text) { 'Hello there!' }

    it 'returns note' do
      get "/api/notes/#{note['id']}"

      expect(last_response.status).to eq(200)
      expect(last_response_json)
        .to include(
          'data' => {
            'id' => be_uuid,
            'type' => 'notes',
            'attributes' => {
              'text' => note_text
            },
            'links' => {
              'self' =>  be_url('api', 'notes', note['id'])
            }
          },
          'links' => {
            'self' =>  be_url('api', 'notes', note['id'])
          }
        )
    end
  end
end
