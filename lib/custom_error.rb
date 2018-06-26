class CustomError < StandardError
  attr_reader :message

  def initialize(msg = nil)
    @message = msg
  end

  def message_local
    message.present? && I18n.exists?(message) ? I18n.t(message) : message
  end
end