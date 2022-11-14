
module Database
  def save_game
    Dir.mkdir("saved_games") unless Dir.exists?("saved_games")
    File.open("./saved_games/saved_one.yaml", "w"){|file| file.write(save_to_yaml)}
  end

  def save_to_yaml
    YAML.dump(
      "name_player" => player.name,
      "name_machine" => machine.name,
      "attack_player" => player.attack,
      "attack_machine" => machine.attack,
      "health_player" => player.health,
      "health_machine" => machine.health
    )
  end

  def load_game
    load_saved_game
    turns
  end

  def load_saved_game
    file = YAML.safe_load(File.read("./saved_games/saved_one.yaml"))
    player.name = file["name_player"]
    machine.name = file["name_machine"]
    player.attack = file["attack_player"]
    machine.attack = file["attack_machine"]
    player.health = file["health_player"]
    machine.health = file["health_machine"]
  end
end