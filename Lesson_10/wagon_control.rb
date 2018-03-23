module WagonControl
  attr_reader :wagons, :wagon_index, :wagon, :wagon_choice

  def create_wagon
    puts 'Выберете 1 для создания ПАССАЖИРСКОГО вагона '
    puts 'Выберете 2 для создания ГРУЗОВОГО вагона '
    wagon_choice = gets.to_i
    create_pasenger_wagon if wagon_choice == 1
    create_cargo_wagon if wagon_choice == 2
  rescue RuntimeError => e
    puts "Ошибка: #{e.message}".red
    retry
  end

  def create_pasenger_wagon
    puts 'Укажите количество мест в вагоне'
    amt = gets.to_i
    wagon = PassengerWagon.new(amt)
    @wagons << wagon
    puts "В депо добавлен ПАССАЖИРСКИЙ вагон на #{wagon.free} мест".green
  end

  def create_cargo_wagon
    puts 'Укажите полезный объем'
    amt = gets.to_i
    wagon = CargoWagon.new(amt)
    @wagons << wagon
    puts "В депо добавлен ГРУЗОВОЙ вагон объемом #{wagon.free} литров".green
  end

  def cargo?
    current_train.class == CargoTrain && wagon.type == :cargo_wagon
  end

  def passenger?
    current_train.class == PassengerTrain && wagon.type == :passenger_wagon
  end

  def add_wagon
    choose_train
    if @wagons.empty?
      puts 'У состава нет вагонов'.red
    else
      choose_wagon
      move_wagon
    end
  end

  def choose_wagon
    wagon_list
    puts 'Выберете вагон по индексу:'
    @wagon_index = gets.to_i
    if !@wagons[wagon_index - 1].nil?
      @wagon = @wagons[wagon_index - 1]
    else
      puts 'Ошибка. Повторите ввод'.red
      return
    end
  end

  def move_wagon
    if cargo? || passenger?
      current_train.add_wagon(wagon)
      @wagons.slice!(wagon_index - 1)
      in_messages
    else
      puts 'Неверный тип!'.red
    end
  end

  def del_wagon
    return puts 'Создайте поезд'.red if @trains.empty?
    choose_train
    return puts 'У состава нет вагонов'.red if current_train.wagons.empty?
    wagon_current_train
    out_wagon if wagon?
  end

  def wagon_current_train
    puts 'Укажите вагон:'
    current_train.wagons.each_with_index do |wagon, index|
      puts "#{index + 1}) #{wagon.view_type}"
    end
    @wagon_choice = gets.to_i
  end

  def out_wagon
    @wagons << current_train.wagons[wagon_choice - 1]
    current_train.del_wagon(wagon_choice - 1)
    out messages
  end

  def out_messages
    puts "От состава #{current_train.number} отцеплен #{wagon.view_type}."
  end

  def in_messages
    puts "К поезду №#{current_train.number} прицеплен #{wagon.view_type}."
  end

  def wagon?
    !current_train.wagons[wagon_choice - 1].nil?
  end
end
