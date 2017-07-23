ENV.update('RACK_ENV' => 'test')

require_relative '../config/application'

Dir[File.join(__dir__, 'support/*.rb')].each { |f| require f }
Dir[File.join(__dir__, 'shared/*.rb')].each { |f| require f }

def app
  Application
end

RSpec.configure do |config|
  config.include JsonRequest
  config.include JsonResponse

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.filter_run_when_matching :focus
  config.example_status_persistence_file_path = '.rspec_results'
  config.disable_monkey_patching!

  config.default_formatter = 'doc' if config.files_to_run.one?

  config.profile_examples = 3

  config.order = :random
  Kernel.srand config.seed
end
