class Program
  attr_accessor :stations, :trains

  def initialize
    @stations = []
    @trains = []
  end

  def create_station
    puts "Введите название станции"
    name = gets.chomp
    stations << Station.new(name)
  end

  def create_train
    puts 'Введите название поезда:'
    name = gets.chomp
    puts 'Введите тип поезда: 1 - пассажирский, 2 - грузовой.'
    type = gets.chomp.to_i

    if type == 1
      create_passenger_train(name)
    elsif type == 2
      create_cargo_train(name)
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
      train.wagons.empty? ? puts('У поезда нет вагонов!') : train.del_wagon(train.wagons.last)
    end
  end

  def set_station_for_train
    if trains.nil?
      puts 'Пока нет ни одного поезда!'
    else
      train = get_train
      station = get_station
      station.receive_train(train)
    end
  end

  def show_stations_list
      stations.empty? ? puts('Пока нет ни одной станции!') : stations.each_with_index { |station, index| puts "#{index + 1} - #{station.name}" }
  end

  def train_list_on_station
    if stations.empty?
      puts 'Пока нет ни одной станции!'
    else
      station = get_station
      station.trains.empty? ? puts('На станции нет ни одного поезда!') : station.trains.each_with_index { |train, index| puts "#{index + 1} - #{train.number}" }
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
    puts 'Введите порядковый номер поезда:'
    number = gets.chomp.to_i

    trains[number - 1]
  end

  def get_station
    show_stations_list
    puts 'Введите порядковый номер станции:'
    number = gets.chomp.to_i
    stations[number - 1]
  end
end
