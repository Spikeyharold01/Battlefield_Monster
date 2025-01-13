extends Node3D

var player_team: Array = []  # Stores the player's monsters
var enemy_team: Array = []   # Stores the enemy monsters
var combat_manager: CombatManager
# UI Reference
@onready var ui = $UI  # Ensure the UI node is a child of combat_scene

func initialize(player_team: Array, enemy_team: Array):
	self.player_team = player_team
	self.enemy_team = enemy_team
	
	# Add monsters to the scene
	var monsters_container = $Monsters
	for monster in player_team + enemy_team:
		monsters_container.add_child(monster)
	
	# Load and instantiate CombatManager
	var combat_manager_script = load("res://scripts/combat/CombatManager.gd")
	combat_manager = combat_manager_script.new()
	 # Pass the UI reference to the CombatManager
	combat_manager.set_ui(ui)
	# Start combat
	combat_manager.start_combat(player_team, enemy_team)

func _input(event):
	if event.is_action_pressed("ui_accept"):
		# Example: Player attacks
		combat_manager.player_attack(combat_manager.turn_order[1])  # Attack the enemy
		combat_manager.end_turn()
