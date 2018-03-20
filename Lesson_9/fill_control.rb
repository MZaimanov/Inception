module FillControl
  def fill_wagon
    train_wagons_list
    puts 'Выберете номер вагона для посадки пассажира или добавления груза:'
    wagon_num = gets.to_i
    wagon = @trains[@number - 1].wagons[wagon_num - 1]
    fill_right(wagon)
  rescue StandardError => e
    puts e
  end

  def fill_right(wagon)
    fill_cargo_wagon if wagon.class == CargoWagon
    fill_passenger_wagon if wagon.class == PassengerWagon
  end

  def fill_cargo_wagon
    puts 'Какой объем груза вы хотите добавить?'
    volume = gets.to_i
    puts 'Груз добавлен в вагон'.green
    wagon.load(volume)
  end

  def fill_passenger_wagon
    wagon.load
    puts 'В вагоне один новый пассажир'.green
  end
end
