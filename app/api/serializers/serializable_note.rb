class SerializableNote < JSONAPI::Serializable::Resource
  type 'notes'

  attributes :text

  link :self do
    "http://example.org/api/notes/#{@object.id}"
  end
end
