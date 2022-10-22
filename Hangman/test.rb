
require 'yaml'

class Fabric
  attr_accessor :car

  def initialize
    @car = Car.new
  end

  def save_game
    dump = YAML.dump(
      'brand' => car.brand,
      'color' => car.color
    )
    File.open('saved_one.yaml', 'w') { |file| file.write dump }
    exit
  end

  def load_game
    file = YAML.safe_load(File.read('saved_one.yaml'), permitted_classes: [Car])
    car.brand = file['brand']
    car.color = file['color']
    play
  end

  def start
    save_game
  end
end

class Car
  attr_accessor :brand, :color

  def initialize
    @brand = "BMW"
    @color = "red"
  end
end

Fabric.new.start
