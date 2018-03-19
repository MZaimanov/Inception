module TrainControl
  attr_reader :name, :train_index,
              :current_train, :move_choice

  def create_train_in
    puts 'Укажите номер поезда:'
    @name = gets.chomp.to_s
    puts 'Укажите тип поезда: 1 - пассажирский, 2 - грузовой.'
    type = gets.chomp.to_i
    train = PassengerTrain.new(@name) if type == 1
    train = CargoTrain.new(@name) if type == 2
    @trains << train
  end

  def create_train
    create_train_in
    puts "Поезд №#{@name} создан.".green
  rescue RuntimeError => e
    puts "Ошибка: #{e.message}"
    retry
  end

  def choose_train
    if @trains.empty?
      puts 'Нет поездов'
    else
      train_list
      puts 'Выберете поезд:'
      @train_index = gets.to_i
      @current_train = @trains[@train_index - 1]
    end
  end

  def train_list_on_station
    train_list_station
    @stations[@num_station - 1].station_trains_list do |train, _index|
      puts "Поезд №#{train.number} - #{train.view_type}".green
      puts "Количество вагонов в составе - #{train.wagons.count}".green
    end
  rescue RuntimeError => e
    puts "Ошибка: #{e.message}"
  end

  def train_list_station
    if @stations.empty?
      puts 'Сначала необходимо создать станцию'.red
    else
      puts 'Список станций:'
      show_stations_list
      puts 'Введите индекс станции для просмотра списка поездов'
      @num_station = gets.to_i
    end
  end

  def train_wagons_list
    train_wagon
    @current_train.wagons_trains_list do |wagon, index|
      puts "Вагон №#{index + 1} - #{wagon.view_type};".green
      puts "Свободно: #{wagon.free};".green
      puts "Занято: #{wagon.filled}".green
    end
  rescue RuntimeError => e
    puts "Ошибка: #{e.message}"
  end

  def train_wagon
    if @trains.empty?
      puts 'Сначала необходимо создать поезд'.red
    else
      puts 'Список поездов:'
      train_list
      puts 'Введите индекс поезда для просмотра списка вагонов'
      @train_index = gets.to_i
      @current_train = @trains[@train_index - 1]
    end
  end

  def move_train_to
    puts '1 - отправить на следующую станцию'
    puts '2 - возвратить на предыдущую станцию'
    @move_choice = gets.to_i
  end

  def move_train_display
    puts "Поезд №#{current_train.number}".green
    puts "прибыл на станцию #{current_train.current_station.name}".green
  end
end
