class Program
  include TrainControl
  include RouteControl
  include WagonControl

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
    create_new_route
  end

  def show_routes
    puts 'Список маршрутов:'
    if @routes.empty?
      puts 'На данный момент маршруты отсутствуют'.red
    else
      @routes.each_with_index { |route, index| puts " :#{index + 1} Маршрут #{route.show_route}" }
    end
  end

  def train_list
    puts 'Список поездов:'
    @trains.each_with_index { |train, index| puts "#{index + 1}) Поезд №#{train.number} #{train.view_type}" }
  end

  def wagon_list
    puts 'Список вагонов в депо:'
    @wagons.each_with_index { |wagon, index| puts "#{index + 1}) #{wagon.view_type}" }
  end

  def set_station_for_train
    return puts 'Необходимо создать станции'.red if @stations.empty?

    if trains.nil?
      puts 'Пока нет ни одного поезда!'.red
    else
      train = train_get
      station = station_get
      station.receive_train(train)
      puts "Поезд №#{train.number} помещен на станцию #{station.name}".green
    end
  end

  def move_train
    move_train_echo
    choose_train
    move_train_to
    current_train.go_next_station if move_choice == 1
    current_train.go_previous_station if move_choice == 2
    move_train_display
  end

  def move_train_echo
    return puts 'Необходимо создать хотябы один маршрут'.red if @routes.empty?
    return puts 'Необходимо создать станции'.red if @stations.empty?
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

  def train_get
    trains.each_with_index { |train, index| puts "#{index + 1} - №#{train.number} #{train.view_type}" }
    puts 'Укажите номер поезда:'
    number = gets.chomp.to_i

    trains[number - 1]
  end

  def station_get
    show_stations_list
    puts 'Укажите номер станции:'
    number = gets.chomp.to_i
    stations[number - 1]
  end
end
