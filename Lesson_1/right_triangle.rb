puts "Введите размер первой стороны"
side_a = gets.chomp.to_f

puts "Введите размер второй стороны"
side_b = gets.chomp.to_f

puts "Введите размер третий стороны"
side_c = gets.chomp.to_f

#Вычислим гипотенузу.

sides = [side_a, side_b, side_c].sort

hypo = sides[2]

#Остаются катеты
cathetus_1 = sides[0]
cathetus_2 = sides[1]

righ_triangle = (hypo ** 2) == (cathetus_1 ** 2 + cathetus_2 ** 2)
isosceles = cathetus_1 == cathetus_2


result = if righ_triangle 
           "Треугольник прямоугольный"
         elsif righ_triangle && isosceles  
           "Треугольник прямоугольный и равнобедренный"
         else "Это треугольник, но не прямоугольный"
         end
puts result
