used_letters = []
hidden_word = "hola"


  hidden_word.split("").each do |letter|
    used_letters.include?(letter) ? hidden_word.gsub!(letter, letter) : hidden_word.gsub!(letter, '_ ')
  end
  
  puts hidden_word