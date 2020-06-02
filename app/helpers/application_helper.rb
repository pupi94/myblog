# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def format_date(date, format = "%Y-%m-%d %H:%M:%S")
    return nil if date.blank?

    date.to_time.strftime format
  end
end
