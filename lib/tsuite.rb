require 'tsuite/version'
require 'rspec/rails/feature_check'

# module Tsuite
# end

if RSpec::Rails::FeatureCheck.has_active_record?
  require 'rspec/core'
  RSpec.configure do |config|
    # Force a "describe" block to work sequentially
    # instead of by using transactions (normally the default)
    # so that you can set up something using before(:all) and have it
    # be cumulative over multiple "it" examples.
    def without_transactions(&block)
      before(:all) do
        if defined?(DatabaseCleaner)
          @previous_database_cleaner_strategy_setting = DatabaseCleaner.strategy
          DatabaseCleaner.strategy = :truncation
        end
        @previous_transactional_fixture_setting = self.use_transactional_fixtures
        self.use_transactional_fixtures = false
      end

      yield

      after(:all) do
        DatabaseCleaner.strategy = @previous_database_cleaner_strategy_setting if defined?(DatabaseCleaner)
        self.use_transactional_fixtures = @previous_transactional_fixture_setting
      end
    end

    # Force a "describe" block have each "it" example operate independently,
    # so that each example starts with the same condition established by any
    # before(:all) or before(:each) blocks.
    def with_transactions(&block)
      before(:all) do
        if defined?(DatabaseCleaner)
          @previous_database_cleaner_strategy_setting = DatabaseCleaner.strategy
          DatabaseCleaner.strategy = :transaction
        end
        @previous_transactional_fixture_setting = self.use_transactional_fixtures
        self.use_transactional_fixtures = false
      end

      yield

      after(:all) do
        DatabaseCleaner.strategy = @previous_database_cleaner_strategy_setting if defined?(DatabaseCleaner)
        self.use_transactional_fixtures = @previous_transactional_fixture_setting
      end
    end
  end
end
