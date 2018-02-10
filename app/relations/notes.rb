require 'entities/note'

class Notes < ROM::Relation[:sql]
   schema do
     attribute :id, Types::String
     attribute :text, Types::String

     primary_key :id
   end
end
