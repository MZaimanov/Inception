class Route

  include InstanceCounter


  attr_reader :stations, :name

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
    register_instance
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    @stations.delete(station)
  end

  def stations_list
    @stations.each{ |station| puts station.name }
  end

  def show_route
    st_start = @stations.first
    st_stop = @stations.last
    puts "#{st_start.name} <===> #{st_stop.name}"
  end

end
