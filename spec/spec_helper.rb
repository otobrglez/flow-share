if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start
end

require 'spork'
require 'webmock'
WebMock.disable!
# WebMock.disable_net_connect!(:allow => "www.example.org:8080")

Spork.prefork do
  require 'webmock'

  ENV["RAILS_ENV"] ||= 'test'

  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'
  require 'factory_girl_rails'
  require 'database_cleaner'
  require 'capybara/rspec'
  # require 'carrierwave/test/matchers'
  # require 'sidekiq/testing'

  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    config.include FactoryGirl::Syntax::Methods
    # config.include CarrierWave::Test::Matchers

    config.fail_fast = ENV['RSPEC_FAIL_FAST'] == "1"
    # config.include Helpers
    config.mock_framework = :rspec # :mocha
    config.order = 'random'

    config.fixture_path = "#{::Rails.root}/spec/fixtures"

    config.filter_run_excluding(no_ci: true) if ENV['CIRCLECI'] == 'true'
    config.filter_run_including(focus: true) unless (ENV['CI'] == 'true') || (ENV['CIRCLECI'] == 'true')

    config.run_all_when_everything_filtered = true

    config.use_transactional_fixtures = false
    config.infer_base_class_for_anonymous_controllers = true
    config.treat_symbols_as_metadata_keys_with_true_values = true

    config.before(:suite) do
      DatabaseCleaner.strategy = :transaction
      DatabaseCleaner.clean_with(:truncation)
    end

    config.before(:each) do
      DatabaseCleaner.start
      # Sidekiq::Extensions::DelayedClass.jobs.clear
      # Sidekiq::Testing.fake!
    end

    config.after(:each) do
      DatabaseCleaner.clean
      # Sidekiq::Testing.disable!
    end

  end

end

Spork.each_run do
#   Rails.cache.reconnect
end
