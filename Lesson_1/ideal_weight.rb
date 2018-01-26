puts "Как Вас завут?"
name = gets.chomp
puts "Привет, #{name}!!!"

puts "#{name}, какой твой рост?"
growth = gets.chomp

ideal = growth.to_i - 110

if ideal >= 0
	puts "#{name}, Ваш идеальный вес #{ideal}"
else 
	puts "#{name}, Ваш вес уже оптимальный!!!"
end
