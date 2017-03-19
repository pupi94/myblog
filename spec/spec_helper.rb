RSpec.configure do |config|
 
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups
end


def expect_success_result(result)
  expect(result['return_code']).to eq ErrorCode::SUCCESS
end

def expect_error_result(result, error_code)
  expect(result['return_code']).to eq error_code
end
