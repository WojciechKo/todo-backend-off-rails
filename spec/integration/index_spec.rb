RSpec.describe 'GET /' do
  it 'returns 200' do
    get '/'

    expect(last_response.status).to eq(200)
    expect(last_response_json).to eq('Server is working')
  end
end
