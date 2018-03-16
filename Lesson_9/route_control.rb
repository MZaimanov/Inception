module RouteControl
  attr_reader :start_station, :end_station,
              :current_route, :to_route

  def create_new_route
    station_to_route
    route = Route.new(start_station, end_station)
    @routes << route
    puts "Маршрут: #{start_station.name} - #{end_station.name} создан".green
  rescue StandardError => e
    puts "Ошибка: #{e.message}"
  end

  def station_to_route
    show_stations_list
    puts 'Укажите номер станции отправления'
    @one_station = gets.chomp.to_i
    @start_station = @stations[@one_station - 1]
    puts 'Укажите номер станции прибытия'
    @two_station = gets.chomp.to_i
    @end_station = @stations[@two_station - 1]
  end

  def edit_route
    choose_route
    puts 'Текущие станции маршрута'
    current_route.stations_list
    puts '1 - добавить станцию в маршрут'
    puts '2 - удалить станцию из маршрута'
    route_choice = gets.to_i
    add_station_route if route_choice == 1
    del_station_route if route_choice == 2
  end

  def choose_route
    return puts 'Необходимо создать хотябы один маршрут'.red if @routes.empty?
    show_routes
    puts 'Укажите маршрут для редоктирования'
    route_index = gets.to_i
    @current_route = @routes[route_index - 1]
  end

  def station_edit_route
    puts 'Список станций:'
    show_stations_list
    puts 'Укажите станцию'
    @to_route = gets.to_i
  end

  def add_station_route
    station_edit_route
    current_route.add_station(@stations[to_route - 1])
    puts 'Станция добавлена. Текущие станции маршрута:'
    current_route.stations_list
  end

  def del_station_route
    station_edit_route
    current_route.delete_station(@stations[to_route - 1])
    puts 'Станция удалена. Текущие станции маршрута:'
    current_route.stations_list
  end
end
