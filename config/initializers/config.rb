require 'types'

class Config < Dry::Struct
  attribute :database_url, ::Types::String

  def self.get
    @get ||= new(
      database_url: ENV.fetch('DATABASE_URL')
    )
  end
end
