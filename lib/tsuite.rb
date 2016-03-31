require 'tsuite/version'
require 'rspec/rails/feature_check'
# require 'cucumber/rails'
# require 'capybara/poltergeist'

module Tsuite
  # Your code goes here...
end

if RSpec::Rails::FeatureCheck.has_active_record?
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

# When we get this next part working, here's the markdown for it:

# Another enhancement for Cucumber testing is to allow most scenarios to run
# with Selenium, and only run selective scenarios with Poltergeist by using this
# syntax:

#     @poltergeist
#     Scenario: Viewing the home page
#       When p_I go to the home page
#       Then p_I should see a list of countries

# # Setting up individual cucumber scenarios to work with Poltergeist instead of selenium
# Around('@poltergeist') do |scenario, block|
#   @capy_def_driver = Capybara.default_driver
#   @capy_js_driver = Capybara.javascript_driver
#   # Just for this scenario, let's go Poltergeist
#   Capybara.default_driver = :poltergeist
#   Capybara.javascript_driver = :poltergeist
#   block.call
#     # Reset it back to the original
#   Capybara.default_driver = @capy_def_driver # Usually :rack_test
#   Capybara.javascript_driver = @capy_js_driver # Usually :selenium
# end
