class Station
  include InstanceCounter
  include Validation

  @@stations = []

  NAME = /^[А-Я]{1}[а-я]+$/

  attr_accessor :trains
  attr_reader :name

  def initialize(name)
    @name = name
    @trains = []
    validate!
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

  def station_trains_list
    raise 'На станции нет поездов'.red if @trains.empty?
    @trains.each do |train|
      yield train if block_given?
    end
  end

  protected

  def validate!
    raise 'Название станции не может быть пустым'.red if name.nil?
    raise 'Название станции пишется по русски и начинается с заглавной буквы'.red if name !~ NAME
    true
  end
end
