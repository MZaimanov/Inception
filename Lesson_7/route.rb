class Route

  include InstanceCounter
  include Validation



  attr_reader :stations, :name

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
    validate!
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

  private

  def validate!
    raise "Не верно введены данные. Повторите".red if @stations.any?(&:nil?)
    raise "Для создания маршрута нужны станции".red if @stations.any? { |station| !station.instance_of? Station }
    raise "Начальная и конечная точки маршрута совпадают".red if @stations.first == @stations.last
    true
  end

end
