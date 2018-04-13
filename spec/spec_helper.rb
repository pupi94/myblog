RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups
end

RSpec::Matchers.define :be_success do
  match do |actual|
    actual['return_code'] == 0
  end

  failure_message do |actual|
    "expected that #{actual.inspect} would have success return code"
  end

  description do
    'be success api result(return code 0)'
  end
end

RSpec::Matchers.define :has_code do |expected|
  match do |actual|
    actual['return_code'] == expected
  end

  failure_message do |actual|
    "expected that #{actual.inspect} would have return code #{expected}"
  end

  description do
    "api result with return code #{expected}"
  end
end