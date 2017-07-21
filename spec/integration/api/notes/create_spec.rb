RSpec.describe 'POST /api/notes' do
  subject { post '/api/notes', params: { 'text' => 'It is my own note' } }

  it_behaves_like 'returns json'

  it 'returns 201' do
    subject

    expect(last_response.status).to eq(201)
    expect(last_response_json).to eq(
      '_links' => { 'self' => { 'href' => 'http://example.org/api/notes/1' } },
      'id' => 1,
      'text' => 'It is my own note'
    )
  end
end
