module ApplicationHelper

  def date_now_str
    now = Time.current
    now_str = format_date(now, '%Y年%m月%d日')
    case now.wday
    when 0
      now_str += "星期天"
    when 1
      now_str += "星期一"
    when 2
      now_str += "星期二"
    when 3
      now_str += "星期三"
    when 4
      now_str += "星期四"
    when 5
      now_str += "星期五"
    when 6
      now_str += "星期六"
    end
    now_str
  end

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
