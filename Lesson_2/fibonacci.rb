array = [0, 1]

fib = 1

while fib < 100
  array << fib
  fib = array[-1] + array[-2]
end

puts array
