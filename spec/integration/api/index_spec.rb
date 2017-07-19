RSpec.describe 'GET /api' do
  it 'returns 200' do
    get '/api'

    expect(last_response.status).to eq(200)
    expect(last_response.body).to eq('Api is working')
  end
end
