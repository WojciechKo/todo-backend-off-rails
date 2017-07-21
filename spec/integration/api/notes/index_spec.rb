RSpec.describe 'GET /api/notes' do
  subject { get '/api/notes' }

  it_behaves_like 'returns json'

  it 'returns notes' do
    subject

    expect(last_response.status).to eq(200)
    expect(last_response_json)
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
