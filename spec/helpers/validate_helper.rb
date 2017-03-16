module ValidateHelper
  def check_validate_object(valid_object, params)
    valid_object.assign_attributes(params)
    valid_object.valid?
  end

  def validate_errors_info(check_result, valid_object, column_name, error_code)
    if error_code == ErrorCode::SUCCESS
      expect(check_result).to eq true
    else
      expect(check_result).to eq false
      expect(valid_object.errors.messages[column_name.to_sym]).to include error_code
    end
  end

  def valid_column_length(valid_object, column_name, column_length, error_code)
    result = check_validate_object(valid_object, column_name => get_a_string(column_length))
    validate_errors_info result, valid_object, column_name, ErrorCode::SUCCESS

    result = check_validate_object(valid_object, column_name => get_a_string(column_length + 1))
    validate_errors_info result, valid_object, column_name, error_code
  end

  def valid_column_present(valid_object, column_name, error_code)
    result = check_validate_object(valid_object, column_name => nil)
    validate_errors_info result, valid_object, column_name, error_code

    result = check_validate_object(valid_object, column_name => '')
    validate_errors_info result, valid_object, column_name, error_code
  end

  def valid_column_range(valid_object, column_name, column_range, error_code)
    expect(valid_object).not_to eq nil
    other_range = []
    rand(1..10).times { other_range << get_rand_string(32) }
    (column_range + other_range).each do |column_value|
      result = check_validate_object(valid_object, column_name => column_value)
      if column_range.include?(column_value)
        expect(result).to eq true
      else
        expect(result).to eq false
        expect(valid_object.errors.messages[column_name.to_sym]).to include error_code
      end
    end
  end

  def get_rand_string(column_length = 32)
    rand_string = ''
    chars = ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a
    rand(1..column_length).times { rand_string << chars[rand(chars.size - 1)] }
    rand_string
  end

  def get_a_string(length)
    length > 0 ? '测' * length : ''
  end
end
