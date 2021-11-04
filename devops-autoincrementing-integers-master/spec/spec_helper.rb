# frozen_string_literal: true

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |_mocks|
    ubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups
end
