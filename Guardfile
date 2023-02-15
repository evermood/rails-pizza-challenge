# A sample Guardfile
# More info at https://github.com/guard/guard#readme

## Uncomment and set this to only include directories you want to watch
# directories %w(app lib config test spec features) \
#  .select{|d| Dir.exist?(d) ? d : UI.warning("Directory #{d} does not exist")}

## Note: if you are using the `directories` clause above and you are not
## watching the project directory ('.'), then you will want to move
## the Guardfile to a watched dir and symlink it back, e.g.
#
#  $ mkdir config
#  $ mv Guardfile config/
#  $ ln -s config/Guardfile .
#
# and, you'll have to watch "config/Guardfile" instead of "Guardfile"

require 'active_support/core_ext/string/inflections'

guard :bundler do
  require 'guard/bundler'
  require 'guard/bundler/verify'
  helper = Guard::Bundler::Verify.new

  files = ['Gemfile']
  files += Dir['*.gemspec'] if files.any? { |f| helper.uses_gemspec?(f) }

  # Assume files are symlinked from somewhere
  files.each { |file| watch(helper.real_path(file)) }
end

# Note: The cmd option is now required due to the increasing number of ways
#       rspec may be run, below are examples of the most common uses.
#  * bundler: 'bundle exec rspec'
#  * bundler binstubs: 'bin/rspec'
#  * spring: 'bin/rspec' (This will use spring if running and you have
#                          installed the spring binstubs per the docs)
#  * zeus: 'zeus rspec' (requires the server to be started separately)
#  * 'just' rspec: 'rspec'

guard :rspec, cmd: "bundle exec rspec",
    all_after_pass: false, all_on_start: false, failed_mode: :focus do
  require "guard/rspec/dsl"
  dsl = Guard::RSpec::Dsl.new(self)

  # Feel free to open issues for suggestions and improvements

  # RSpec files
  rspec = dsl.rspec
  watch(rspec.spec_helper) { rspec.spec_dir }
  watch(rspec.spec_support) { rspec.spec_dir }
  watch(rspec.spec_files)

  # Ruby files
  ruby = dsl.ruby
  dsl.watch_spec_files_for(ruby.lib_files)

  # Rails files
  rails = dsl.rails(view_extensions: %w(erb haml slim jbuilder))
  dsl.watch_spec_files_for(rails.app_files)
  dsl.watch_spec_files_for(rails.views)

  watch(rails.controllers) do |m|
    [
      rspec.spec.call("routing/#{m[1]}_routing"),
      rspec.spec.call("controllers/#{m[1]}_controller"),
      rspec.spec.call("requests/#{m[1]}")
    ]
  end

  # forms, fields, and partials
  watch(%r{^app/(.*)_form(.*)(\.erb|\.haml|\.slim)$}) do |m|
    [
      "spec/#{m[1]}edit#{m[2]}#{m[3]}_spec.rb",
      "spec/#{m[1]}new#{m[2]}#{m[3]}_spec.rb",
    ]
  end
  watch(%r{^app/(.*)\/_.*fields(.*)(\.erb|\.haml|\.slim)$}) do |m|
    [
      "spec/#{m[1]}/edit#{m[2]}#{m[3]}_spec.rb",
      "spec/#{m[1]}/new#{m[2]}#{m[3]}_spec.rb",
    ]
  end
  watch(%r{^app/(.*)\/_.*(\.json.jbuilder)$}) do |m|
    [
      "spec/#{m[1]}/index#{m[2]}_spec.rb",
      "spec/#{m[1]}/show#{m[2]}_spec.rb"
    ]
  end
  watch(%r{^app/(.*)_index(.*)(\.erb|\.haml|\.slim)$}) do |m|
    "spec/#{m[1]}index#{m[2]}#{m[3]}_spec.rb"
  end

  # Rails config changes
  watch(rails.spec_helper)     { rspec.spec_dir }
  watch(rails.routes)          { "#{rspec.spec_dir}/routing" }
  watch(rails.app_controller)  { "#{rspec.spec_dir}/controllers" }

  # Capybara features specs
  watch(rails.view_dirs) { |m| ["spec/features/#{m[1]}_spec.rb", "spec/requests/#{m[1]}_spec.rb"] }
  watch(rails.layouts)       { |m| rspec.spec.call("features/#{m[1]}") }

  # Turnip features and steps
  watch(%r{^spec/acceptance/(.+)\.feature$})
  watch(%r{^spec/acceptance/steps/(.+)_steps\.rb$}) do |m|
    Dir[File.join("**/#{m[1]}.feature")][0] || "spec/acceptance"
  end

  # Factory Bot
  watch(%r{^spec/factories/(.+)\.rb$}) do |m|
    [
      "spec/controllers/#{m[1]}_controller_spec.rb",
      "spec/models/#{m[1].singularize}_spec.rb",
      "spec/views/#{m[1]}",
    ]
  end

  # translations
  watch(%r{config/locales/(.*)_.*\.yml}) do  |m|
    [
      "spec/extra/i18n_integration_spec.rb",
      "spec/controllers/#{m[1]}_controller_spec.rb",
      "spec/models/#{m[1].singularize}_spec.rb",
      "spec/views/#{m[1]}",
    ]
  end

  # Ability
  watch(%r{^spec/models/ability/(.+)\.rb$}) {"spec/models/ability_spec.rb"}
end
