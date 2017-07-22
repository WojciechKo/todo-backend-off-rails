guard :bundler do
  require 'guard/bundler'
  require 'guard/bundler/verify'
  helper = Guard::Bundler::Verify.new

  files = ['Gemfile']
  files += Dir['*.gemspec'] if files.any? { |f| helper.uses_gemspec?(f) }

  # Assume files are symlinked from somewhere
  files.each { |file| watch(helper.real_path(file)) }
end

guard :rubocop do
  watch(%r{\A.+\.rb$\z})
end

guard :reek, cli: '--single-line --no-wiki-links' do
  watch(%r{\A.+\.rb$\z})
  watch('.reek')
end

guard :rspec, cmd: 'bundle exec rspec', failed_mode: :keep do
  # Run all specs if configuration is modified
  watch('Gemfile.lock') { 'spec' }
  watch('spec/spec_helper.rb') { 'spec' }

  # Run all specs if supporting files files are modified
  watch(%r{\Aspec/(?:support)/.+\.rb\z}) { 'spec' }

  watch(%r{\Aconfig/application\.rb\z}) { 'spec' }
  watch(%r{\Aapp/(.+)\.rb$}) { 'spec' }

  # Run a spec if it is modified
  watch(%r{\Aspec/(?:unit|integration)/.+_spec\.rb\z})
  watch(%r{^lib/(.+)\.rb}) { |m| "spec/lib/#{m[1]}_spec.rb" }
end
