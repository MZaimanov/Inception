class Train

  TYPE = [:passanger, :cargo]

  attr_accessor :number
  attr_reader :type

  def initialize(number, type, wagon)
    @number = number
    @type = type
    @wagon = wagon
    @stations = stations
    @speed = 0
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

  def add_wagon
    if @speed.zero?
      @wagon += 1
    else
      puts "Остановите поезд...демоны"
    end
  end

  def del_wagon
    if @speed.zero?
      @wagon -= 1 if @wagon > 0
    else
      puts "Остановите поезд...демоны"
    end
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
    if next_station != @route.stations.last
      current_station.send_train(self)
      @station_index += 1
      current_station.receive_train(self)
    else
      current_station
    end
  end

  def go_previous_station
    if next_station != @route.stations.last
      current_station.send_train(self)
      @station_index -= 1
      current_station.receive_train(self)
    else
      current_station
    end
  end

end
