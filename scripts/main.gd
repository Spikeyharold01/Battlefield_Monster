extends Node3D


func _ready():
	# Initialize the player's monster
	var player_monster = spawn_monster("res://data/monsters/Blood_queen.json")
	
	# Initialize the enemy monster
	var enemy_monster = spawn_monster("res://data/monsters/Couatl.json")
	
	# Load the combat scene
	var combat_scene = load("res://scenes/combat/combat_scene.tscn").instantiate()
	add_child(combat_scene)
	
	# Pass the player and enemy monsters to the combat scene
	combat_scene.initialize([player_monster], [enemy_monster])

func spawn_monster(json_path: String) -> Monster:
	# Load the monster scene
	var monster_scene = load("res://scenes/monsters/MonsterTemplate.tscn")  # A generic monster scene
	var monster_instance = monster_scene.instantiate()
	
	# Load JSON data
	JsonLoader.load_monster(json_path, monster_instance)
	

	
	return monster_instance
