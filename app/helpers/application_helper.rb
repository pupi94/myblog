module ApplicationHelper

  def format_date(date, format = '%Y-%m-%d %H:%M:%S')
    return nil if date.blank?
    date.to_time.strftime format
  end

  def show_status(status)
    status ? t('common.enabled') : t('common.disabled')
  end
end
