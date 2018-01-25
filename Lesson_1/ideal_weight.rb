puts "Как Вас завут?"
name = gets.chomp
puts "Привет, #{name}!!!"

puts "#{name}, какой твой рост?"
weight = gets.chomp

ideal = weight.to_i - 110

if ideal >= 0
	puts "#{name}, Ваш идеальный вес #{ideal}"
elsif ideal < 0
	puts "#{name}, Ваш вес уже оптимальный!!!"
end
