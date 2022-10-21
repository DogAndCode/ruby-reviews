# frozen_string_literal: true

system 'clear'

class Game
  def initialize
    @player = Player.new
    @word
    @guesses = 15
    @used_letters = []
    @looser = false
    @winner = false
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
    counter = 1
    @word.split(//).each do |letter|
      if @used_letters.include?(letter)
        print letter
        counter += 1
        @winner = true if @word.length == counter
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
    if @guesses.negative?
      @looser = true
      puts 'NO MORE GUESSES, YOU LOST'
      puts "The word was: #{@word}"
    end
  end

  def play_again?
    play_again = ''
    puts 'Do you wanna play again?(y/n)'
    answer = gets.chomp.downcase
    answer == 'y' ? Game.new.start : puts('Thank you. See you soon!')
  end

  def start
    welcome
    ask_player_name
    random_word
    while @winner == false && @looser == false
      show_hidden_word
      player_letter_choice
      looser?
    end
    winner? if @winner == true
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
