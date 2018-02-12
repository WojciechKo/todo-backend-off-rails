module Resources::Notes
  extend JsonApiCalls

  module_function

  def create_note(text)
    post '/api/notes', params: { 'text' => text }
  end
end
