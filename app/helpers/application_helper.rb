module ApplicationHelper

  def format_date(date, format = '%Y-%m-%d %H:%M:%S')
    return nil if date.blank?
    date.to_time.strftime format
  end

  def show_status(status)
    if status
      return t 'common.enabled'
    else
      return t 'common.disabled'
    end
  end
end
