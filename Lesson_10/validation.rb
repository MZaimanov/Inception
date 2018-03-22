module Validation
  def self.included(base)
    base.extend         ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :attr_validations

    def validate(name, validation, *arg)
      # self.attr_validations ||= {}
      # attr_validations[attribute] ||= {}
      # attr_validations[attribute].store(validation, arg)
      @validations ||= []
      @validations << { name: name, validation: validation, arg: arg }
    end
  end

  module InstanceMethods
    def validate!
      puts self
      puts self.class
      puts self.class.attr_validations
      self.class.attr_validations.each do |attribute, validations|
        attribute_val = instance_variable_get("@#{attribute}".to_sym)
        validations.each { |meth, arg| send(meth, attribute, attribute_val,arg) }
      end
      true
    end

    def valid?
      validate!
    rescue StandardError
      false
    end

    protected

    #def presence(attribute, attribute_val, arg)
    def presence(attribute_val)
      raise "#{attribute} can't be nil" if arg && attribute_val.nil?
    end

    #def format(attribute, attribute_val, pattern)
    def format(name, pattern)
      raise "#{attribute} has invalid format" if attribute_val !~ pattern
    end

    #def type(attribute, attribute_val, this_class)
    def format(name, this_class)
      raise "#{attribute} is not #{this_class} class" unless attribute_val.instance_of? this_class
    end

    #def length(attribute, attribute_val, number)
    def length(name, number)
      raise "#{attribute} should be at least #{number} symbols" if attribute_val.length < number
    end
  end
end


