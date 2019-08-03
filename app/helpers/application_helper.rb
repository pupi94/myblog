# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def format_date(date, format = '%Y-%m-%d %H:%M:%S')
    return nil if date.blank?

    date.to_time.strftime format
  end

  def show_status(status)
    status ? t('common.enabled') : t('common.disabled')
  end

  def notice_list
    Notice.order(created_at: :desc).limit(5)
  end
end
