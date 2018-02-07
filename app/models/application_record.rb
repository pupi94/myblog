class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :enabled, -> { where(enabled: true) }
  scope :disabled, -> { where(enabled: false) }

  scope :page_filter, ->(page_size, page) do
    page, page_size = page.to_i, page_size.to_i
    page = page < DEFAULT_PAGE ? DEFAULT_PAGE : page
    page_size = page_size <= 0 ? DEFAULT_PAGE_SIZE : page_size

    limit(page_size).offset(page_size * (page - 1))
  end

  def self.handle_create(params)
    obj = new
    obj.handle_assign_attributes(params)
    obj.handle_save!
    obj
  end

  def handle_save!
    handle_valid
    handle_save
  end

  def handle_save
    begin
      save
    rescue Exception => e
      raise DatabaseException.new(e.message)
    end
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

  def handle_destroy
    begin
      destroy
    rescue Exception => e
      raise DatabaseException.new(e.message)
    end
  end

  def handle_update!(params)
    handle_assign_attributes(params)
    handle_save!
  end

  def handle_update(params)
    handle_assign_attributes(params)
    handle_save
  end

  private
  def handle_valid
    raise CommonException.new(errors.messages.first[1][0]) if !valid?
  end
end