RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner[:sequel].db = ROM_CONTAINER.gateways[:default].connection
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
