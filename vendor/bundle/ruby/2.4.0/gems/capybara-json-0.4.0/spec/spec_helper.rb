require "bundler/setup"

require "pry"
require "tapp"

ROOT = File.dirname(__FILE__)

require 'capybara/json'
Dir[File.expand_path("support/**/*.rb", ROOT)].each {|f| require f }

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
end
