module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def instances
      class_variable_get(:@@instances)
    end
  end

  module InstanceMethods
    @@instances = 0

    private

    def register_instance
      @@instances += 1
    end
  end
end
