class CustomError < RuntimeError
  def initialize(msg = nil)
    @msg = msg
  end

  def message
    @msg
  end

  def message_zh
    @msg.present? && I18n.exists?(@msg) ? I18n.t(@msg) : @msg
  end
end