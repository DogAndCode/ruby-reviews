
require_relative "../ddbb/database.rb"
require "yaml"

class Game
  include Database
  attr_accessor :player, :machine

  def initialize
    @player = Player.new
    @machine = Machine.new
    play_game
  end

  def play_game
    puts "[LOAD] a game or [START] a new game?"
    answer = gets.chomp
    answer == "start" ? new_game : load_game
  end

  def new_game
    player.select_name
    machine.select_name
    turns
  end

  def turns
    loop do
      break if win?
      player.punch(machine)
      machine.display_state
      machine.punch(player)
      player.display_state
      ask_save_game
    end
    display_winner
  end

  def ask_save_game
    puts "[SAVE] game?(Y/N)"
    answer = gets.chomp
    answer == "yes" ? save_game : nil
  end

  def win?
    machine.health <= 0 || player.health <= 0
  end

  def display_winner
    puts player.health <= 0 ? "#{machine.name} wins!" : "#{player.name} wins!"
  end
end

class Player
  attr_accessor :name, :attack, :health

  def initialize
    @name = nil
    @attack = rand(1..4)
    @health = 30
  end

  def select_name
    puts "What is your name?"
    self.name = gets.chomp
  end

  def punch(enemy)
    puts "Head or Chest?"
    answer = gets.chomp
    ko = ["head", "chest"].sample
    if answer == ko
      damage = rand(1..8) + attack + 10
      puts "AYUUUUKEEEN"
    else
      damage = rand(1..8) + attack
    end
    enemy.health -= damage
  end

  def display_state
    puts "#{name} health is: #{health}"
  end

  def to_s
    "#{name} has:
    - Attack: #{attack}
    - Defense: #{defense}
    - Health: #{health}"
  end
end

class Machine < Player
  def initialize
    super
  end

  def punch(enemy)
    damage = rand(1..8) + attack
    enemy.health -= damage
  end

  def select_name
    file = File.read("./ddbb/names.txt").split
    self.name = "Dirty #{file.sample}"
  end
end