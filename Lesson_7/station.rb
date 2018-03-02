class Station

  include InstanceCounter
  @@stations = []

  NAME = /^[А-Я]{1}[а-я]+$/

  attr_accessor :trains
  attr_reader :name

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    register_instance
    validate!
  end

  def valid?
    validate!
  rescue
    false
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

  protected

  def validate!
    raise "Название станции не может быть пустым" if name.nil?
    raise "Название станции пишется по русски и начинается с заглавной буквы" if name !~ NAME
    true
  end
end
