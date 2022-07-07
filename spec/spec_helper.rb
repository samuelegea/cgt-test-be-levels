# frozen_string_literal: true

require 'rubygems'
require 'bundler/setup'

require 'support/init_database'
require 'support/database_cleaner'
require 'factory_bot'

require 'simplecov'
SimpleCov.start

require 'cgtrader_levels'

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    FactoryBot.find_definitions
  end
end
# RSpec.configure do |config|
# end
