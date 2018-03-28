module ModelValidate
  def self.included(klass)
    klass.extend ClassMethods
  end

  module ClassMethods
    def included(klass)
      validates_block = class_variable_get '@@_validates_block'
      klass.class_eval(&validates_block)
    end

    def attr_validates(&validates_block)
      class_variable_set '@@_validates_block', validates_block
    end
  end
end