require 'spec_helper'

RSpec.describe 'GET /api/notes' do
  subject { get '/api/notes' }

  it_behaves_like 'returns json'

  it 'returns empty notes' do
    subject

    expect(last_response.status).to eq(200)
    expect(last_response_json)
      .to include(
        '_links' => {
          'self' => {
            'href' => be_url('api', 'notes')
          }
        },
        'count' => 0,
        '_embedded' => {
          'notes' => []
        }
      )
  end

  context 'with single note' do
    let!(:note) do
      post '/api/notes', params: {'text' => 'simple note'}
      last_response_json
    end

    it 'returns single note' do
      subject

      expect(last_response.status).to eq(200)
      expect(last_response_json)
        .to include(
          '_links' => {
            'self' => {
              'href' => be_url('api', 'notes')
            }
          },
          'count' => 1,
          '_embedded' => {
            'notes' =>
            [
              {
                '_links' => {
                  'self' => {
                    'href' => be_url('api', 'notes', note['id'])
                  },
                },
                'id' => note['id'],
                'text' => note['text']
              }
            ]
          }
        )
    end
  end
end
