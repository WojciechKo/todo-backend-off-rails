RSpec.describe 'GET /api' do
  subject { get '/api' }

  it_behaves_like 'returns json'

  it 'returns 200' do
    subject

    expect(last_response.status).to eq(200)
    expect(last_response_json).to eq('Api is working')
  end
end
