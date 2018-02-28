class Station

  include InstanceCounter
  @@stations = []

  attr_accessor :trains
  attr_reader :name

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    register_instance
  end

  def self.all
    @@stations
  end

  def receive_train(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end

  def train_type(type)
    @trains.count { |train| train.type == type }
  end
end
