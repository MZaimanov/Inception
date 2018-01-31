puts "Введите день своего рождения: "
date = gets.chomp.to_i
puts "месяц: "
month = gets.chomp.to_i 
puts "год: "
year = gets.chomp.to_i

days_and_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
days_and_month[1] = 29 if year % 400 == 0 || ( year % 4 == 0 && year % 100 != 0)

sum = 0
for i in 0..month - 2
  sum += days_and_month[i]
end
sum += date

puts "Порядковый номер даты с начала года: #{sum}"
