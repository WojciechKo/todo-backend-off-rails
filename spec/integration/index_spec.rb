RSpec.describe 'GET /' do
  subject { get '/' }

  it_behaves_like 'returns json'

  it 'returns 200' do
    subject

    expect(last_response.status).to eq(200)
    expect(last_response_json).to eq('Server is working')
  end
end
