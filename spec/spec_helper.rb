# frozen_string_literal: true

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, type: :system, js: true) do
    if ENV['DEBUG'] == 'true'
      driven_by :selenium, using: :chrome, screen_size: [1600, 900]
    else
      driven_by :selenium, using: :headless_chrome, screen_size: [1600, 900]
    end
  end

  config.before(:each, type: :system, js: true, debug: true) do
    driven_by :selenium, using: :chrome, screen_size: [1600, 900]
  end

  # Do not show "booting puma" message in the middle of the specs
  config.before(:all, type: :system) do
    Capybara.server = :puma, { Silent: true }
  end

  # rspec-mocks config goes here. You can use an alternate test double
  # library (such as bogus or mocha) by changing the `mock_with` option here.
  config.mock_with :rspec do |mocks|
    # Prevents you from mocking or stubbing a method that does not exist on
    # a real object. This is generally recommended, and will default to
    # `true` in RSpec 4.
    mocks.verify_partial_doubles = true
  end

  # This option will default to `:apply_to_host_groups` in RSpec 4 (and will
  # have no way to turn it off -- the option exists only for backwards
  # compatibility in RSpec 3). It causes shared context metadata to be
  # inherited by the metadata hash of host groups and examples, rather than
  # triggering implicit auto-inclusion in groups with matching metadata.
  config.shared_context_metadata_behavior = :apply_to_host_groups
end
