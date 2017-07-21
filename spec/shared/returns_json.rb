RSpec.shared_examples 'returns json' do
  it 'response contains application/json Content-Type' do
    subject
    expect(last_response.headers['Content-Type']).to eq('application/json')
  end
end
