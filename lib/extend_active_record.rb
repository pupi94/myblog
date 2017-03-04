module ActiveRecord
  class Base
    def self.handle_create(params)
      obj = new
      obj.handle_assign_attributes(params)
      obj.handle_save!
      return obj
    end

    def handle_update(params)
      handle_assign_attributes(params)
      handle_save
    end

    def handle_update!(params)
      handle_assign_attributes(params)
      handle_save!
    end

    def handle_assign_attributes(params)
      begin
        assign_columns = attribute_names - ['id']
        (0...assign_columns.size).each { |idx| assign_columns << assign_columns[idx].to_sym }
        assign_attributes(params.slice(*(assign_columns)))
      rescue Exception => e
        raise ParamsException.new(e.message)
      end
    end

    def handle_valid
      raise CommonException.new(errors.messages.first[1][0]) if !valid?
    end

    def handle_save
      begin
        save
      rescue Exception => e
        raise DatabaseException.new(e.message)
      end
    end

    def handle_save!
      handle_valid
      handle_save
    end

    def handle_destroy
      begin
        destroy
      rescue Exception => e
        raise DatabaseException.new(e.message)
      end
    end
  end
end
