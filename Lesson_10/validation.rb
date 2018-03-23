module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :validations

    def validate(attribute, validation, arg)
      self.validations ||= {}
      validations[attribute] ||= {}
      validations[attribute].store(validation, arg)
    end
  end


  module InstanceMethods
    def validate!
      puts self
      puts self.class
      puts self.class.validations
      self.class.validations.each do |attribute, validations|
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

    def presence(attribute, validation, arg)
      raise "#{attribute} не может быть пустым" if arg && validation.nil?
    end

    def format(attribute, validation, pattern)
      raise "#{attribute} неверный формат" if validation !~ pattern
    end

    def type(attribute, validation, this_class)
      raise "#{attribute} не соответствует #{this_class} классу" unless validation.instance_of? this_class
    end

    def length(attribute, validation, number)
      raise "#{attribute} должен быть не менее #{number} символов" if validation.to_s.length < number
    end
  end
end


