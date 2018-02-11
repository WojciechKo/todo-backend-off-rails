RSpec.describe 'GET /api' do
  subject { get '/api' }

  it { is_expected.to return_json(200, 'Api is working') }
end
