RSpec.describe 'GET /' do
  it 'returns 200' do
    get '/'

    expect(last_response.status).to eq(200)
    expect(json_response).to eq('Server is working')
  end
end
