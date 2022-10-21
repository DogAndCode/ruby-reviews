# REFACTORIZAR
# SALVAR EL JUEGO EN YAML Y JSON
# SUBIRLO GIT Y DECIRSELO A ROLI
# COMPARARLO CON EL ANTERIOR QUE HICE
system 'clear'

class Game
  attr_accessor :word, :used_letters, :winner, :guesses, :hidden_word, :looser

  def initialize
    @player = Player.new
    @word = ''
    @guesses = 15
    @used_letters = []
    @looser = false
    @winner = false
  end

  def ask_player_name
    puts '### WELCOME to THE HANGMAN GAME!! ###', '### You have 8 attempts ###', '### GOOD LUCK! ###', '', "What's your name?"
    @player.name = gets.chomp
    puts '', "Nice to meet you #{@player.name}"
  end

  def random_word
    @word = File.readlines('words_list.txt', chomp: true).sample
    @hidden_word = word.clone
  end

  def show_hidden_word
    puts 'This is the word you have to guess: '
    hidden_word.split("").each do |letter|
      used_letters.include?(letter) ? hidden_word.gsub!(letter, letter) : hidden_word.gsub!(letter, '_ ')
    end
    puts hidden_word
    show_stats
  end
  
  def show_stats
    puts ' ', "\nLetters used: #{used_letters}", "Remaining guesses: #{guesses}"
  end

  def compare_word_with_hidden_word
    hidden_word == word ? winner = true : nil
  end

  def player_letter_choice
    puts 'Choose a letter: '
    letter = gets.chomp.downcase
    if used_letters.include?(letter)
      puts '', 'Repeated, choose a different one'
    elsif letter.length > 1
      puts 'ONLY ONE LETTER. Try again!'
    elsif letter =~ /[a-z]/
      used_letters << letter
      self.guesses -= 1
    else
      puts 'Wrong choice. ONLY LETTERS allowed', ''
    end
  end

  def winner?
    puts "The word is: #{word}", '', 'CONGRATULATIONS, you WON!'
  end

  def looser?
    if guesses <= 0
      looser = true
      puts 'NO MORE GUESSES, YOU LOST', "The word was: #{word}"
    end
  end

  def start
    ask_player_name
    random_word
    show_hidden_word
    compare_word_with_hidden_word # ESTAS ORDENANDO, VAS POR AQUI, MOMENTO DE LOOP CONDICIONAL PARA PODER JUGAR
    player_letter_choice
    looser?
    play_again?
  end

  def play_again?
    puts 'Do you wanna play again?(y/n)'
    answer = gets.chomp.downcase
    answer == 'y' ? Game.new.start : puts('Thank you. See you soon!')
  end
end

class Player
  attr_accessor :name

  def initialize
    @name = ''
  end
end

Game.new.start
