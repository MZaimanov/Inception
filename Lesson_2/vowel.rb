alphabet = "абвгдеёжзийклмнопрстуфхцчшщъыьэюя"
vowel= "аеёиоуыэюя"
vowel_hash = Hash.new

vowel.each_char { |vowel| vowel_hash[vowel] = alphabet.index(vowel) + 1 }

puts vowel_hash
