class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :enabled_filter, -> { where(enabled: true) }
  scope :disabled_filter, -> { where(enabled: false) }

  scope :page_filter, ->(page_size, page) do
    page, page_size = page.to_i, page_size.to_i
    page = page < DEFAULT_PAGE ? DEFAULT_PAGE : page
    page_size = page_size <= 0 ? DEFAULT_PAGE_SIZE : page_size

    limit(page_size).offset(page_size * (page - 1))
  end
end