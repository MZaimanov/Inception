puts "Введите  коэффициент 1"
coefficient_a = gets.chomp.to_f

puts "Введите  коэффициент 2"
coefficient_b = gets.chomp.to_f

puts "Введите  коэффициент 3"
coefficient_c = gets.chomp.to_f

discriminant = coefficient_b ** 2 - 4 * coefficient_a * coefficient_c

results = if discriminant > 0 
  x1 = (-coefficient_b + Math.sqrt(discriminant)) / (2 * coefficient_a)
  x2 = (-coefficient_b - Math.sqrt(discriminant)) / (2 * coefficient_a)
  "Дискриминант: #{discriminant}, Корень x1 равен #{x1}, Корень x2 равен #{x2}"
elsif discriminant == 0
  x1 = (-coefficient_b) / (2 * coefficient_a)
  "Дискриминант: #{discriminant}, Корень x1 равен Корню x2 и равен #{x1}"
else
  "Корней нет"
end
puts results
