RSpec.describe 'GET /api/notes/{:id}' do
  it 'returns single note' do
    get '/api/notes/1'

    expect(last_response.status).to eq(200)
    expect(json_response)
      .to include(
        '_links' => {
          'self' => { 'href' => 'http://example.org/api/notes/1' }
        },
        'id' => 1,
        'text' => 'Simple note'
      )
  end
end
