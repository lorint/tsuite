require 'capybara/poltergeist'

# Allow individual cucumber scenarios to work with Poltergeist instead of selenium
Around('@poltergeist') do |scenario, block|
  @capy_def_driver = Capybara.default_driver
  @capy_js_driver = Capybara.javascript_driver
  # Just for this scenario, let's go Poltergeist
  Capybara.default_driver = :poltergeist
  Capybara.javascript_driver = :poltergeist
  block.call
    # Reset it back to the original
  Capybara.default_driver = @capy_def_driver # Usually :rack_test
  Capybara.javascript_driver = @capy_js_driver # Usually :selenium
end
