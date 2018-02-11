require 'spec_helper'

RSpec.describe 'GET /api/notes' do
  subject { get '/api/notes' }

  it_behaves_like 'returns json'

  it 'returns empty notes' do
    subject

    expect(last_response.status).to eq(200)
    expect(last_response_json)
      .to match(
        'data' => [],
        'meta' => {
          'count' => 0
        },
        'links' => {
          'self' => be_url('api', 'notes')
        }
      )
  end

  context 'with single note' do
    let!(:note) do
      post '/api/notes', params: { 'text' => 'simple note' }
      last_response_json['data']
    end

    it 'returns single note' do
      subject

      expect(last_response.status).to eq(200)
      expect(last_response_json)
        .to match(
          'data' => [
            {
              'id' => note['id'],
              'type' => 'notes',
              'attributes' => {
                'text' => note['attributes']['text']
              },
              'links' => {
                'self' => be_url('api', 'notes', note['id'])
              }
            }
          ],
          'meta' => {
            'count' => 1
          },
          'links' => {
            'self' => be_url('api', 'notes')
          }
        )
    end
  end
end
