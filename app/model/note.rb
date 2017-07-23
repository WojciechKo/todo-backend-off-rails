class Note < Dry::Struct
  attribute :id, Types::Coercible::Int
  attribute :text, Types::Coercible::String
end
