class Program
  include TrainControl
  include RouteControl
  include WagonControl
  include FillControl

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
    if @stations.count < 2
      puts 'Для создания маршрута необходимы две точки назначения '.red
    else
      create_new_route
    end
  end

  def show_routes
    puts 'Список маршрутов:'
    if @routes.empty?
      puts 'На данный момент маршруты отсутствуют'.red
    else
      @routes.each_with_index { |r, i| puts "#{i + 1} Маршрут #{r.show_route}" }
    end
  end

  def train_list
    puts 'Список поездов:'
    @trains.each_with_index do  |train, index|
      puts "#{index + 1}) Поезд №#{train.number} #{train.view_type}"
    end
  end

  def wagon_list
    puts 'Список вагонов в депо:'
    @wagons.each_with_index do |wagon, index|
      puts "#{index + 1}) #{wagon.view_type}"
    end
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
    if @stations.empty?
      puts 'Пока нет ни одной станции!'.red
    else
      @stations.each_with_index { |s, i| puts "#{i + 1} - #{s.name}" }
    end
  end

  private

  def train_get
    trains.each_with_index do |train, index|
      puts "#{index + 1} - №#{train.number} #{train.view_type}"
    end
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
