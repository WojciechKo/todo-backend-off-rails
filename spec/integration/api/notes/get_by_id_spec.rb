RSpec.describe 'GET /api/notes/{:id}' do
  subject { get "/api/notes/#{note_id}" }
  let(:note_id) { 'abcdefgh' }

  context 'when note not found' do
    xit 'returns error' do
      subject
    end
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
