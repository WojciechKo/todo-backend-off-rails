RSpec.describe 'POST /api/notes' do
  subject { post '/api/notes', params: { 'text' => 'It is my own note' } }

  let(:response) do
    {
      'data' => {
        'id' => be_uuid,
        'type' => 'notes',
        'attributes' => {
          'text' => 'It is my own note'
        },
        'links' => {
          'self' =>  be_url('api', 'notes', :uuid)
        }
      },
      'links' => {
        'self' =>  be_url('api', 'notes')
      }
    }
  end

  it { is_expected.to return_json(201, response) }
end
