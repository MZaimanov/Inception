class Program
  attr_accessor :stations, :trains

  def initialize
    @stations = []
    @trains = []
    @routes = []
  end

  def add_station
    puts "Введите название станции"
    name = gets.chomp
    stations << Station.new(name)
  end

  def create_train
    puts "Введите название поезда:"
    name = gets.chomp
    puts "Введите тип поезда: 1 - пассажирский, 2 - грузовой."
    type = gets.chomp.to_i

    if type == 1
      create_passenger_train(name)
    elsif type == 2
      create_cargo_train(name)
    end
  end

  def create_route
    return puts "Для создания маршрута необходимы две точки назначения" if @stations.count < 2

    show_stations_list

    puts "Выберете номер станции отправления"
    one_station = gets.chomp.to_i

    if @stations.include? @stations[one_station - 1]
      start_station = @stations[one_station - 1]
    else
      puts "Не верно введена станция отправления"
    end

    puts "Выберете номер станции прибытия"
    two_station = gets.chomp.to_i

    if @stations.include? @stations[two_station - 1]
      end_station = @stations[two_station - 1]
    else
      puts "Не верно введена станция назначения"
    end

    route = Route.new(start_station, end_station)
    @routes << route
    puts "#{@routes}" #УДАЛИТЬ ПЕРЕД ОТПРАВКОЙ НА ПРАВЕРКУ!!!!
  end

  def show_routes
    puts "Список маршрутов:"
    if @routes.empty?
      puts "На данный момент маршруты отсутствуют"
    else
      @routes.each_with_index { |route, index| puts " :#{index + 1} Маршрут #{route.show_route}"}
    end
  end

  def edit_route
    return puts "Необходимо создать хотябы один маршрут" if @routes.empty?

    show_routes

    puts "Выберете маршрут для редоктирования"
    route_index = gets.to_i
    current_route = @routes[route_index - 1]

    if current_route != nil
      puts "Текущие станции маршрута"
      current_route.stations_list
      puts "1 - добавить станцию в маршрут"
      puts "2 - удалить станцию из маршрута"
      route_choice = gets.to_i
      if route_choice == 1
        puts "Список станций:"
        show_stations_list
        puts "Введите номер станции для добавления"
        to_route = gets.to_i
        current_route.add_station(@stations[to_route - 1])
        puts "Станция добавлена. Текущие станции маршрута:"
        current_route.stations_list
      elsif route_choice == 2
        puts "Список станций:"
        show_stations_list
        puts "Введите номер станции для удаления"
        out_route = gets.to_i
        current_route.delete_station(@stations[out_route - 1])
        puts "Станция удалена. Текущие станции маршрута:"
        current_route.stations_list
      else
        puts "Введите верные данные."
        return
      end
    else
      puts "Повторите"
    end
  end

  def train_list
      @trains.each_with_index { |train, index| puts "#{index + 1}) Поезд №#{train.number} #{train.view_type}"}
  end

  def get_route
      return puts "Необходимо создать хотябы один поезд." if @trains.empty?
      puts "Список поездов:"
      train_list
      puts "Выберете поезда для задания ему маршрута"
      num = gets.to_i
      if @trains.count >= num
        if @routes.empty?
          puts "Нет ни одного маршрута"
          create_route
        else
          show_routes
          puts "Выберете номер маршрута для поезда #{@trains[num - 1].number}"
          train_route_choice = gets.to_i
          train_current_route = @routes[train_route_choice - 1]
          @trains[num - 1].add_route(train_current_route)
          puts "Маршрут #{train_current_route.show_route}назначен Поезду #{@trains[num - 1].number}"
        end
      else
        puts "Повторите ввод!"
        add_route
      end
  end

  def add_wagon
    if trains.nil?
      puts "Создайте поезд"
    else
      train = get_train
      if train.type == :passenger_train
        train.add_wagon(PassengerWagon.new)
      elsif train.type == :cargo_train
        train.add_wagon(CargoWagon.new)
      end
    end
  end

  def del_wagon
    if trains.nil?
      puts "Создайте поезд"
    else
      train = get_train
      train.wagons.empty? ? puts("У поезда нет вагонов!") : train.del_wagon(train.wagons.last)
    end
  end

  def set_station_for_train
    if trains.nil?
      puts "Пока нет ни одного поезда!"
    else
      train = get_train
      station = get_station
      station.receive_train(train)
    end
  end

  def move_train
    return puts "Необходимо создать хотябы один поезд." if @trains.empty?

    return puts "Необходимо создать хотябы один маршрут" if @routes.empty?

    return puts "Необходимо создать станции" if @stations.empty?

    puts "Список поездов:"
    train_list
    puts "Введите порядковый номер поезда для отправления"
    num = gets.to_i
    current_train = @trains[num - 1]

    if @trains.count >= num && @trains[num - 1] != nil
      puts "1 - отправить на следующую станцию"
      puts "2 - возвратить на предыдущую станцию"
      move_choice = gets.to_i
      if move_choice == 1
        current_train.go_next_station
        puts "Поезд №#{current_train.number} прибыл на станцию #{current_train.current_station.name}"
      elsif move_choice == 2
        current_train.go_previous_station
        puts "Поезд №#{current_train.number} прибыл на станцию #{current_train.current_station.name}"
      else
        puts "Повторите ввод."
        move_train
      end
    else
      puts "Неверный порядковый номер или поезду не назначен маршрут."
      move_train
    end
  end

  def show_stations_list
      @stations.empty? ? puts("Пока нет ни одной станции!") : @stations.each_with_index { |station, index| puts "#{index + 1} - #{station.name}" }
  end

  def train_list_on_station
    if stations.empty?
      puts "Пока нет ни одной станции!"
    else
      station = get_station
      station.trains.empty? ? puts("На станции нет ни одного поезда!") : station.trains.each_with_index { |train, index| puts "#{index + 1} - #{train.number}" }
    end
  end

  private

  def create_passenger_train(name)
    trains << PassengerTrain.new(name)
  end

  def create_cargo_train(name)
    trains << CargoTrain.new(name)
  end

  def get_train
    trains.each_with_index { |train, index| puts "#{index + 1} - #{train.number}" }
    puts "Введите порядковый номер поезда:"
    number = gets.chomp.to_i

    trains[number - 1]
  end

  def get_station
    show_stations_list
    puts "Введите порядковый номер станции:"
    number = gets.chomp.to_i
    stations[number - 1]
  end
end
