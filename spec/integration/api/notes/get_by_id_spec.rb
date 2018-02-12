RSpec.describe 'GET /api/notes/{:id}' do
  subject { get "/api/notes/#{note_id}" }

  context 'when invalid id' do
    let(:note_id) { 'abcdefgh' }
    let(:response) do
      {
        'errors' =>
        [
          { 'status' => '400',
            'title' => 'Invalid id',
            'detail' => 'Can not find a note with given id',
            'source' => {
              'parameter' => 'id'
            } }
        ]
      }
    end

    it { is_expected.to return_json(400, response) }
  end

  context 'when note not found' do
    let(:note_id) { '123e4567-e89b-12d3-a456-426655440000' }
    let(:response) do
      {
        'errors' =>
        [
          { 'status' => '400',
            'title' => 'Invalid id',
            'detail' => 'Can not find a note with given id',
            'source' => {
              'parameter' => 'id'
            } }
        ]
      }
    end

    it { is_expected.to return_json(400, response) }
  end

  context 'when note found' do
    let(:note_id) { note['id'] }
    let(:note) { Resources::Notes.create_note(note_text).json['data'] }
    let(:note_text) { 'Hello there!' }

    let(:response) do
      {
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
      }
    end

    it { is_expected.to return_json(200, response) }
  end
end
