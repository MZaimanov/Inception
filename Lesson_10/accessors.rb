module Accessors
  def self.included(receiver)
    receiver.extend ClassMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*names)
      names.each do |name|
        var_name = "@#{name}".to_sym
        var_name_history = "@#{name}_history".to_sym
        define_method(name) { instance_variable_get(var_name) }
        define_method("#{name}=".to_sym) do |value|
          var = instance_variable_get(var_name)
          var_history = instance_variable_get(var_name_history) || []
          instance_variable_set(var_name_history, var_history << var) unless var.nil?
          instance_variable_set(var_name, value)
        end
        define_method("#{name}_history".to_sym) { instance_variable_get(var_name_history) }
      end
    end

    def strong_attr_accessor(name, this_class)
      var_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}= ".to_sym) do |value|
        raise ArgumentError, "'#{value}' is not #{this_class} class" unless value.instance_of? this_class
        instance_variable_set(var_name, value)
      end
    end
  end
end
