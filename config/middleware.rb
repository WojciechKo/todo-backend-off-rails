module Middleware
  Dir[File.join(__dir__, 'middleware/*.rb')] .each { |f| require f }
end
