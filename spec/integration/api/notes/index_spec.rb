require 'spec_helper'

RSpec.describe 'GET /api/notes' do
  subject { get '/api/notes' }

  context 'with empty note list' do
    let(:response) do
      {
        'data' => [],
        'meta' => {
          'count' => 0
        },
        'links' => {
          'self' => be_url('api', 'notes')
        }
      }
    end

    it { is_expected.to return_json(200, response) }
  end

  context 'with single note' do
    let!(:note) do
      response = post '/api/notes', params: { 'text' => 'simple note' }
      response.json['data']
    end

    let(:response) do
      {
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
      }
    end

    it { is_expected.to return_json(200, response) }
  end
end
