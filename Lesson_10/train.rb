class Train
  include CompanyName
  include InstanceCounter
  include Validation
  include Accessors


  attr_reader :number, :speed, :wagons

  attr_accessor_with_history :route

  NUMBER = /^[а-я0-9]{3}-?[а-я0-9]{2}$/i

  validate :number, :presence, true
  validate :number, :format, NUMBER
  validate :number, :length, 5

  @@trains = {}

  def self.find(number)
    @@trains[number]
  end


  def initialize(number)
    @number = number
    validate!
    @wagons = []
    @speed = 0
    @@trains[number] = self
    register_instance
  end

  def speed_up(value)
    @speed += value
  end

  def speed_down(value)
    @speed -= value
    @speed = 0 if value < 0
  end

  def stop
    @speed = 0
  end

  def current_speed
    @speed
  end

  def add_wagon(wagon)
    raise 'Остановите поезд...демоны' unless @speed.zero?
    @wagons << wagon
  rescue RuntimeError => e
    puts "Ошибка: #{e.message}"
  end

  def del_wagon(wagon)
    raise 'Остановите поезд...демоны' unless @speed.zero?
    @wagons.delete(wagon)
  rescue RuntimeError => e
    puts "Ошибка: #{e.message}"
  end

  def current_number_wagon
    @wagon
  end

  def add_route(route)
    @route = route
    @station_index = 0
    current_station.receive_train(self)
  end

  def current_station
    @route.stations[@station_index]
  end

  def next_station
    @route.stations[@station_index + 1] if @station_index != @route.stations.size - 1
  end

  def previous_station
    @route.stations[@station_index - 1] if @station_index != 0
  end

  def go_next_station
    puts "#{@route}"
    if current_station != @route.stations.last
      current_station.send_train(self)
      @station_index += 1
      current_station.receive_train(self)
    else
      current_station
    end
  end

  def go_previous_station
    if current_station != @route.stations.first
      current_station.send_train(self)
      @station_index -= 1
      current_station.receive_train(self)
    else
      current_station
    end
  end

  def wagons_trains_list
    raise 'У поезда нет вагонов'.red if @wagons.empty?
    @wagons.each_with_index do |index, wagon|
      yield(index, wagon) if block_given?
    end
  end

# protected

#   attr_writer :speed, :route

#   def validate!
#     raise 'Номер поезда не может быть пустым' if number.nil?
#     raise 'Формат номера: XXX-XX'.red if number !~ NUMBER
#     true
#   end
end
