module Health
  def heal(quantity)
    self.health += 1
  end

  def hurt(quantity)
    self.health -= 1
  end
end

module Armor
  def attach_armor
    "I'm wearing armor"
  end

  def remove_armor
    "I'm removing my armor"
  end
end

module CastSpell
  def spell
    "Abracadabra!!!"
  end
end

module Potions
  def create_potions
    "I'm making the perfect potion"
  end
end

module Additions
  attr_accessor :strength, :intelligence
  attr_reader :name, :health

  def roll_dice
    [*1..10].sample
  end

  def to_s
    "Name: #{name}\nClass: #{self.class}\nHealth: #{health}\nStrength: #{strength}\nIntelligence: #{intelligence}"
  end
end


class Warrior
  include Health
  include Armor

  def initialize(name)
    @name = name
    @health = 100
    @strength = roll_dice + 2
    @intelligence = roll_dice
  end

  private

  include Additions
end

class Magician
  include Health
  include CastSpell

  def initialize(name)
    @name = name
    @health = 100
    @strength = roll_dice
    @intelligence = roll_dice + 2
  end

  private

  include Additions
end

class Bard < Magician
  include Potions
end

class Paladin
  include Health
  include CastSpell

  def initialize(name)
    @name = name
    @health = 100
    @strength = roll_dice
    @intelligence = roll_dice
  end

  private

  include Additions
end

bardy = Bard.new("Bardy")
puts bardy.spell
puts bardy.intelligence
merlin = Magician.new("Merlin")
puts merlin.intelligence
puts merlin.strength
