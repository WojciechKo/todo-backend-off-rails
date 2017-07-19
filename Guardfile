guard :bundler do
  require 'guard/bundler'
  require 'guard/bundler/verify'
  helper = Guard::Bundler::Verify.new

  files = ['Gemfile']
  files += Dir['*.gemspec'] if files.any? { |f| helper.uses_gemspec?(f) }

  # Assume files are symlinked from somewhere
  files.each { |file| watch(helper.real_path(file)) }
end

guard :rspec, cmd: 'bundle exec rspec', failed_mode: :keep do
  #run all specs if configuration is modified
  watch('Guardfile') { 'spec' }
  watch('Gemfile.lock') { 'spec' }
  watch('spec/spec_helper.rb') { 'spec' }

  # run all specs if supporting files files are modified
  watch(%r{\Aspec/(?:support)/.+\.rb\z}) { 'spec' }

  watch(%r{\Aconfig/application\.rb\z}) { 'spec' }
  watch(%r{\Aapp/api\.rb\z}) { 'spec' }

  # run a spec if it is modified
  watch(%r{\Aspec/(?:unit|integration)/.+_spec\.rb\z})
end

guard :rubocop do
  watch(%r{.+\.rb$})
  watch(%r{(?:.+/)?\.rubocop(?:_todo)?\.yml$}) { |m| File.dirname(m[0]) }
end
