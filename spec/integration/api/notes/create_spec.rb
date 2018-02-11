RSpec.describe 'POST /api/notes' do
  subject { post '/api/notes', params: { 'text' => 'It is my own note' } }

  it_behaves_like 'returns json'

  it 'returns 201' do
    subject

    expect(last_response.status).to eq(201)
    expect(last_response_json).to match(
      'data' => {
        'id' => be_uuid,
        'type' => 'notes',
        'attributes' => {
          'text' => 'It is my own note'
        },
        'links' => {
          'self' =>  be_url('api', 'notes', :uuid)
        }
      },
      'links' => {
        'self' =>  be_url('api', 'notes')
      }
    )
  end
end
