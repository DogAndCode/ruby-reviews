# ADD LOAD AND SAVE GAME
# ENVIAR A GIT
# REPASAR LO APRENDIDO
# NEXT LESSON
system 'clear'

require "yaml"

class Game
  attr_accessor :word, :used_letters, :winner_or_looser, :guesses

  def initialize
    @player = Player.new
    @word = ''
    @guesses = 15
    @used_letters = []
    @winner_or_looser = false
  end

  def ask_new_or_load
    puts "Do you want to [start] a new game or [load] a saved game?"
    answer = gets.chomp
    answer == "start" ? play : load_game
  end

  def load_game

  end

  def ask_player_name
    puts '### WELCOME to THE HANGMAN GAME!! ###', '### You have 8 attempts ###', '### GOOD LUCK! ###', '',
         "What's your name?"
    @player.name = gets.chomp
    puts '', "Nice to meet you #{@player.name}"
  end

  def random_word
    until word.size.between?(5, 12)
      @word = File.readlines('words_list.txt', chomp: true).sample
    end
  end

  def show_hidden_word
    puts 'This is the word you have to guess: '
    word.split('').each do |letter|
      used_letters.include?(letter) ? print(letter) : print('_ ')
    end
    show_stats
  end

  def show_stats
    puts "\n**Letters used: #{used_letters}", "**Remaining guesses: #{guesses}"
  end

  def player_letter_choice
    puts '=> Choose a letter: '
    letter = gets.chomp.downcase
    if used_letters.include?(letter)
      puts '', 'Repeated, choose a different one'
    elsif letter.length > 1
      puts "", 'ONLY ONE LETTER. Try again!'
    elsif letter =~ /[a-z]/
      used_letters << letter
      self.guesses -= 1
    else
      puts 'Wrong choice. ONLY LETTERS allowed', ''
    end
  end

  def check_winner_or_looser
    if (word.split('').uniq - used_letters).empty?
      self.winner_or_looser = true
      puts "The word is: #{word}", '', 'CONGRATULATIONS, you WON!'
    elsif guesses <= 0
      self.winner_or_looser = true
      puts "SORRY, you LOST. The word was: #{word}"
    end
  end

  def play_again?
    puts 'Do you wanna play again?(y/n)'
    answer = gets.chomp.downcase
    answer == 'y' ? Game.new.start : puts('Thank you. See you soon!')
  end

  def start
    ask_new_or_load
    ask_player_name
    random_word
    until winner_or_looser
      show_hidden_word
      player_letter_choice
      check_winner_or_looser
    end
    play_again?
  end
end

class Player
  attr_accessor :name

  def initialize
    @name = ''
  end
end

game = Game.new
game.start
