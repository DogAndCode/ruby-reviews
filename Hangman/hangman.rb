        # PONER EL COUNTER A CERO DE ALGUNA MANERA PARA QUE SE IGUALEN
        # SALVAR EL JUGO EN YAML Y JSON
        # REFACTORIZAR
        # SUBIRLO GIT Y DECIRSELO A ROLI
        # COMPARARLO CON EL ANTERIOR QUE HICE

system 'clear'

require "yaml"

class Game
  def initialize
    @player = Player.new
    @word = ""
    @guesses = 15
    @used_letters = []
    @looser = false
    @winner = false
    @counter = 0
  end

  def welcome
    puts '### WELCOME to THE HANGMAN GAME!! ###', '### You have 8 attempts ###', '### GOOD LUCK! ###', ''
  end

  def ask_player_name
    puts "What's your name?"
    @player.name = gets.chomp
    puts '', "Nice to meet you #{@player.name}"
  end

  def random_word
    @word = File.readlines('words_list.txt', chomp: true).sample
  end

  def show_hidden_word
    puts 'This is the word you have to guess: '
    @word.split(//).each do |letter|
      if @used_letters.include?(letter)
        print letter
        @counter += 1
        @winner = true if @word.length == @counter
      else
        print '_ '
      end
    end
    puts ' ', "\nLetters used: #{@used_letters}", "Remaining guesses: #{@guesses}"
  end

  def player_letter_choice
    puts 'Choose a letter: '
    letter = gets.chomp.downcase
    if @used_letters.include?(letter)
      puts '', 'Repeated, choose a different one'
    elsif letter.length > 1
      puts 'ONLY ONE LETTER. Try again!'
    elsif letter =~ /[a-z]/
      @used_letters << letter
      @guesses -= 1
    else
      puts 'Wrong choice. ONLY LETTERS allowed', ''
    end
  end

  def winner?
    system 'clear'
    puts "The word is: #{@word}"
    puts '', 'CONGRATULATIONS, you WON!'
  end

  def looser?
    if @guesses <= 0
      @looser = true
      puts 'NO MORE GUESSES, YOU LOST'
      puts "The word was: #{@word}"
    end
  end

  def start
    welcome
    ask_player_name
    random_word
    until @winner || @looser
      show_hidden_word
      if @winner == true
        puts "You WON"
        break
      end
      player_letter_choice
      looser?
      @counter = 0
    end
    play_again?
  end

  def play_again?
    play_again = ''
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

game = Game.new
game.start
