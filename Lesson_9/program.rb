class Program
  include TrainControl

  attr_accessor :stations, :trains, :routes, :wagons

  def initialize
    @stations = []
    @trains = []
    @routes = []
    @wagons = []
  end

  def create_station
    puts 'Укажите название станции'
    name = gets.chomp.to_s
    stations << Station.new(name)
    puts "Создана станция: #{name}".green
  rescue RuntimeError => e
    puts "Ошибка: #{e.message}".red
    retry
  end

  def create_route
    return puts 'Для создания маршрута необходимы две точки назначения'.red if @stations.count < 2

    show_stations_list
    puts 'Укажите номер станции отправления'
    one_station = gets.chomp.to_i

    @stations.include?(@stations[one_station - 1])
    start_station = @stations[one_station - 1]

    puts 'Укажите номер станции прибытия'
    two_station = gets.chomp.to_i

    @stations.include?(@stations[two_station - 1])
    end_station = @stations[two_station - 1]

    route = Route.new(start_station, end_station)
    @routes << route
    puts "Маршрут: #{start_station.name} - #{end_station.name} создан".green
  rescue Exception => e
    puts "Ошибка: #{e.message}"
  end

  def show_routes
    puts 'Список маршрутов:'
    if @routes.empty?
      puts 'На данный момент маршруты отсутствуют'.red
    else
      @routes.each_with_index { |route, index| puts " :#{index + 1} Маршрут #{route.show_route}" }
    end
  end

  def edit_route
    return puts 'Необходимо создать хотябы один маршрут'.red if @routes.empty?

    show_routes

    puts 'Укажите маршрут для редоктирования'
    route_index = gets.to_i
    current_route = @routes[route_index - 1]

    if !current_route.nil?
      puts 'Текущие станции маршрута'
      current_route.stations_list
      puts '1 - добавить станцию в маршрут'
      puts '2 - удалить станцию из маршрута'
      route_choice = gets.to_i
      if route_choice == 1
        puts 'Список станций:'
        show_stations_list
        puts 'Укажите станцию для добавления'
        to_route = gets.to_i
        current_route.create_station(@stations[to_route - 1])
        puts 'Станция добавлена. Текущие станции маршрута:'
        current_route.stations_list
      elsif route_choice == 2
        puts 'Список станций:'
        show_stations_list
        puts 'Укажите станцию для удаления'
        out_route = gets.to_i
        current_route.delete_station(@stations[out_route - 1])
        puts 'Станция удалена. Текущие станции маршрута:'
        current_route.stations_list
      else
        puts 'Укажите верные данные.'.red
        return
      end
    else
      puts 'Повторите'.red
    end
  end

  def train_list
    @trains.each_with_index { |train, index| puts "#{index + 1}) Поезд №#{train.number} #{train.view_type}" }
  end

  def get_route
    return puts 'Необходимо создать хотябы один поезд.'.red if @trains.empty?
    puts 'Список поездов:'
    train_list
    puts 'Выберете поезда для задания ему маршрута'
    num = gets.to_i
    if @trains.count >= num
      if @routes.empty?
        puts 'Нет ни одного маршрута'.red
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
      puts 'Повторите ввод!'.red
      add_route
    end
  end

  def create_wagon
    puts 'Выберете 1 для создания ПАССАЖИРСКОГО вагона'
    puts 'Выберете 2 для создания ГРУЗОВОГО вагона'
    wagon_choice = gets.to_i
    if wagon_choice == 1
      puts 'Укажите количество мест в вагоне'
      amt = gets.to_i
      wagon = PassengerWagon.new(amt)
      @wagons << wagon
      puts "В депо добавлен новый ПАССАЖИРСКИЙ вагон на #{wagon.free} мест".green
    elsif wagon_choice == 2
      puts 'Укажите полезный объем'
      amt = gets.to_i
      wagon = CargoWagon.new(amt)
      @wagons << wagon
      puts "В депо добавлен новый ГРУЗОВОЙ вагон полезным объемом #{wagon.free} литров".green
    else
      puts 'Ошибка. Повторите ввод'.red
      return
    end
  end

  def add_wagon
    return puts 'Нет ни одного поезда. Создайте хотябы один поезд.'.red if @trains.empty?
    return puts 'В депо нет вагонов. Создайте новые или отцепите имеющиеся'.red if @wagons.empty?

    puts 'Список поездов:'
    train_list
    puts 'Введите № поезда для добавления вагонов'
    num = gets.to_i
    if @trains.count >= num
      current_train = @trains[num - 1]
      puts current_train.class
      puts 'Список вагонов в депо:'
      wagon_list
      puts 'Выберете вагон по индексу:'
      wagon_choice = gets.to_i
      wagon = @wagons[wagon_choice - 1]
      if current_train.class == CargoTrain && wagon.type == :cargo_wagon && !wagon.nil?
        current_train.add_wagon(wagon)
        @wagons.slice!(wagon_choice - 1)
        puts "К поезду №#{current_train.number} прицеплен один ГРУЗОВОЙ вагон. #{current_train.wagons}".green
      elsif current_train.class == PassengerTrain && wagon.type == :passenger_wagon && !wagon.nil?
        current_train.add_wagon(wagon)
        @wagons.slice!(wagon_choice - 1)
        puts "К поезду №#{current_train.number} прицеплен один ПАССАЖИРСКИЙ вагон. #{current_train.wagons}".green
      else
        puts 'Выберете правельный тип вагона'.red
        return
      end
    else
      puts 'Ошибка. Повторите ввод'.red
      return
    end
  end

  def del_wagon
    return puts 'Создайте поезд'.red if @trains.empty?
    puts 'Список поездов:'
    train_list
    puts 'Укажите состав для отцепления вагонов'
    num = gets.to_i
    if @trains.count >= num
      current_train = @trains[num - 1]
      if current_train.wagons.count > 0
        puts 'Укажите вагон для отцепления:'
        current_train.wagons.each_with_index { |wagons, index| puts "#{index + 1}) #{wagons.view_type}" }
        wagons_choice = gets.to_i
        @wagons << current_train.wagons[wagons_choice - 1]
        current_train.wagons[wagons_choice - 1]
        puts "От состава #{current_train.number} отцеплен один вагон.".green
      else
        puts 'Состав не имеет вагонов.'.red
      end
    else
      puts 'Указан не верный состав'.red
    end
  end

  def wagon_list
    @wagons.each_with_index { |wagon, index| puts "#{index + 1}) #{wagon.view_type}" }
  end

  def set_station_for_train
    return puts 'Необходимо создать станции'.red if @stations.empty?

    if trains.nil?
      puts 'Пока нет ни одного поезда!'.red
    else
      train = get_train
      station = get_station
      station.receive_train(train)
      puts "Поезд №#{train.number} помещен на станцию #{station.name}".green
    end
  end

  def move_train
    return puts 'Необходимо создать хотябы один поезд.'.red if @trains.empty?

    return puts 'Необходимо создать хотябы один маршрут'.red if @routes.empty?

    return puts 'Необходимо создать станции'.red if @stations.empty?

    puts 'Список поездов:'
    train_list
    puts 'Укажите порядковый номер поезда для отправления'
    num = gets.to_i
    current_train = @trains[num - 1]

    if @trains.count >= num && @trains[num - 1].nil?
      puts 'Неверный порядковый номер или поезду не назначен маршрут.'.red
      return
    else
      puts '1 - отправить на следующую станцию'
      puts '2 - возвратить на предыдущую станцию'
      move_choice = gets.to_i
      if move_choice == 1
        current_train.go_next_station
        puts "Поезд №#{current_train.number} прибыл на станцию #{current_train.current_station.name}".green
      elsif move_choice == 2
        current_train.go_previous_station
        puts "Поезд №#{current_train.number} прибыл на станцию #{current_train.current_station.name}".green
      else
        puts 'Повторите ввод.'.red
        move_train
      end
    end
  end

  def show_stations_list
    @stations.empty? ? puts('Пока нет ни одной станции!'.red) : @stations.each_with_index { |station, index| puts "#{index + 1} - #{station.name}" }
  end

  def fill_wagon
    raise 'Нет вагонов у поезда'.red if train_wagons_list.nil?
    train_wagons_list
    puts 'Выберете номер вагона для посадки пассажира или добавления груза:'
    wagon_num = gets.to_i
    wagon = @trains[@number - 1].wagons[wagon_num - 1]
    if wagon.class == CargoWagon
      puts 'Какой объем груза вы хотите добавить?'
      volume = gets.to_i
      puts 'Груз добавлен в вагон'.green
      wagon.load(volume)
    elsif wagon.class == PassengerWagon
      wagon.load
      puts 'В вагоне один новый пассажир'.green
    end
  rescue RuntimeError => e
    puts "Ошибка: #{e.message}"
  end

  private

  def get_train
    trains.each_with_index { |train, index| puts "#{index + 1} - №#{train.number} #{train.view_type}" }
    puts 'Укажите номер поезда:'
    number = gets.chomp.to_i

    trains[number - 1]
  end

  def get_station
    show_stations_list
    puts 'Укажите номер станции:'
    number = gets.chomp.to_i
    stations[number - 1]
  end
end
