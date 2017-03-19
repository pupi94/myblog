module ApplicationHelper
  def show_status(status)
    if status
      return t 'common.enable'
    else
      return t 'common.disable'
    end
  end
end
