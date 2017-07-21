RSpec.describe 'GET /api/notes' do
  it 'returns notes' do
    get '/api/notes'

    expect(last_response.status).to eq(200)
    expect(json_response)
      .to include(
        '_links' => {
          'self' => { 'href' => 'http://example.org/api/notes' }
        },
        'count' => 1,
        '_embedded' => {
          'notes' =>
          [
            '_links' => {
              'self' => { 'href' => 'http://example.org/api/notes/1' }
            },
            'id' => 1,
            'text' => 'Simple note'
          ]
        }
      )
  end
end
