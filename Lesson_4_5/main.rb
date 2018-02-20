require_relative 'train.rb'
require_relative 'station.rb'
require_relative 'route.rb'
require_relative 'wagon.rb'
require_relative 'passenger_wagon.rb'
require_relative 'passenger_train.rb'
require_relative 'cargo_wagon.rb'
require_relative 'cargo_train.rb'
require_relative 'program.rb'

main = Program.new

loop do
  puts '--------------'
  puts 'Введите необходимое число:'
  puts '1 - Создание станции'
  puts '2 - Создание поезда'
  puts '3 - Прицепить вагон к составу'
  puts '4 - Отцепить вагон от состава'
  puts '5 - Поместить поезд на станцию'
  puts '6 - Просмотреть список станций'
  puts '7 - Просмотреть список поездов на станции'
  puts '8 - Выход'

  action_number = gets.chomp.to_i

case action_number
  when 1
    main.create_station
  when 2
    main.create_train
  when 3
    main.add_wagon
  when 4
    main.del_wagon
  when 5
    main.set_station_for_train
  when 6
    main.show_stations_list
  when 7
    main.train_list_on_station
  when 8
    break
  else
    next
  end
end

puts "До новых встреч!"
