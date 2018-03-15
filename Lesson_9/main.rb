require_relative 'train_control.rb'
require_relative 'validation.rb'
require_relative 'instance_counter.rb'
require_relative 'company_name.rb'
require_relative 'train.rb'
require_relative 'station.rb'
require_relative 'route.rb'
require_relative 'wagon.rb'
require_relative 'passenger_wagon.rb'
require_relative 'passenger_train.rb'
require_relative 'cargo_wagon.rb'
require_relative 'cargo_train.rb'
require_relative 'program.rb'
require_relative 'colors.rb'

main = Program.new

loop do
  puts '=========================='
  puts 'Укажите необходимое число:'
  puts '1 - Создание станции'
  puts '2 - Создание поезда'
  puts '3 - Создание маршрута'
  puts '4 - Редоктирование маршрута'
  puts '5 - Просмотр текцщих маршрутов'
  puts '6 - Назначение маршрута поезду'
  puts '7 - Создать вагон в депо'
  puts '8 - Прицепить вагон к составу'
  puts '9 - Отцепить вагон от состава'
  puts '10 - Поместить поезд на станцию'
  puts '11 - Перемещение состава по маршруту'
  puts '12 - Просмотреть список станций'
  puts '13 - Просмотреть список поездов на станции'
  puts '14 - Посмотреть список вагонов у поезда'
  puts '15 - Посадка/загрузка вагона'
  puts '0 - Выход'
  puts '==========================='

  action_number = gets.chomp.to_i

  case action_number
  when 1
    main.create_station
  when 2
    main.create_train
  when 3
    main.create_route
  when 4
    main.edit_route
  when 5
    main.show_routes
  when 6
    main.get_route
  when 7
    main.create_wagon
  when 8
    main.add_wagon
  when 9
    main.del_wagon
  when 10
    main.set_station_for_train
  when 11
    main.move_train
  when 12
    main.show_stations_list
  when 13
    main.train_list_on_station
  when 14
    main.train_wagons_list
  when 15
    main.fill_wagon
  when 0
    break
  else
    next
  end
end

puts 'До новых встреч!'
