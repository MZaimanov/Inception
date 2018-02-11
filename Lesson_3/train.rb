class Train

TYPE = [:passanger, :cargo]
WAGON_ACTION = [:up, :down]

  attr_accessor :speed, :number, :wagon, :route, :station
  attr_reader :type

  def initialize(number, type, wagon)
    @number = number
    @type = type
    @wagon = wagon
    @speed = 0
  end

   def speed_up
  	self.speed += 10
  end

  def stop
  	self.speed = 0
  end

  def add_wagon(wagon)
  	if speed.zero?
  		if wagon == WAGON_ACTION[0]
  			@wagon += 1
  		elsif wagon == WAGON_ACTION[1]
  			@wagon -= 1
  		else
  			puts "Неизвестное значение"
  		end
  	else
  		puts "Остановите поезд...демоны"
  	end
  end

  def add_route(route)
    @current_route = route
    @station_index = 0
    current_station.receive_train(self)
  end

  def current_station
    @current_route.stations_list[@station_index]
  end

  def next_station
    @current_route.stations_list[@station_index + 1] if @station_index != @current_route.stations_list.size - 1
  end

  def previous_station
    @current_route.stations_list[@index_station - 1] if @station_index != 0
  end
  



  def go_next_station
    if current_station != @current_route.stations_list.last
      current_station.send_train(self)
      @station_index += 1
      current_station.receive_train(self)
    else
      current_station
    end
  end

  def go_previous_station
    if current_station != @current_route.stations_list.last
      current_station.send_train(self)
      @station_index -= 1
      current_station.receive_train(self)
    else
      current_station
    end
  end

end
