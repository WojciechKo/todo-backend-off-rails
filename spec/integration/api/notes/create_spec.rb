RSpec.describe 'POST /api/notes' do
  subject { post '/api/notes', params: { 'text' => 'It is my own note' } }

  it_behaves_like 'returns json'

  it 'returns 201' do
    subject

    expect(last_response.status).to eq(201)
    expect(last_response_json).to match(
      '_links' => {
        'self' => {
          'href' => be_url('api', 'notes', :uuid)
        }
      },
      'id' => be_uuid,
      'text' => 'It is my own note'
    )
  end
end
