RSpec.describe 'GET /' do
  subject { get '/' }

  it { is_expected.to return_json(200, 'Application is working') }
end
