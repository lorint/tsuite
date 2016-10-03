# Tsuite

Ever get tired of adding multiple gems for testing Rails apps?  Add this one line to your Gemfile:

```ruby
gem 'tsuite', group: :test
```

and you'll get these 7 gems:

* rspec-rails
* cucumber-rails
* database_cleaner
* simplecov
* launchy
* rack_session_access
* poltergeist

Bundle, and then it's easy to configure everything with one generator:

    $ rails g tsuite:install

Additionally, with RSpec tests you have a new block you can use to selectively
cause a group of "it" blocks to run sequentially, without transaction rollbacks:

```ruby
describe Item do
  before(:all) do
    @red_item = Item.create(color: "red", is_fixed_color: false, cost: 100)
    @blue_item = Item.create(color: "red", is_fixed_color: true, cost: 100)
  end

  context "with a non-fixed color"
    without_transactions do  # <== MAKES THIS PART RUN CUMULATIVELY
      it "should be able to change color" do
        @red_item.update(color: "green")
        expect(@red_item).to be_valid
      end
      it "will still be the same changed color in another example" do
        # Look ma, no rollback:
        expect(@red_item.color).to eq("green")
      end
    end
  end

  context "with a fixed color"
    # ...
  end
end
```

Another enhancement for Cucumber testing is to allow most scenarios to run
with Selenium, and only run selective scenarios with Poltergeist by using this
syntax:

```ruby
  @poltergeist
  Scenario: Viewing the home page
    Given I am logged on as a "Travel Agent"
    When p_I go to the home page
    Then p_I should see a list of countries
```

## A shout out:

Props out to Ketan Patel who came up with the original idea for this gem.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/lorint/tsuite. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
