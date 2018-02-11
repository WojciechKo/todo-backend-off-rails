module NoteApi
  module_function

  extend JsonRequest
  extend JsonResponse

  def create_note(text)
    post '/api/notes', params: { 'text' => text }
    last_response_json
  end
end
