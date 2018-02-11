basket = Hash.new
sum = 0

loop do
  print "Введите название товара (или \"стоп\"): "
  name = gets.chomp
  break if name == "стоп"

  print "Введите цену товара: "
  price = gets.chomp.to_f

  print "Введите количество товара: "
  count = gets.chomp.to_i
  
  basket[name] = { "price" => price, "count" => count }  
end 

total = 0
basket.each do |name, hash| 
  sum = hash["price"] * hash["count"]
  total += sum
	puts "Итогова сумма за: #{name}: #{total}"
end

puts "Итого: #{sum}"
puts basket
