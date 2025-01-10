extends Node

class_name CombatManager

var turn_order: Array = []  # Stores combatants in initiative order
var current_turn_index: int = 0
var combatants: Array = []  # Stores all combatants (player and enemy monsters)
var player_team: Array = []  # Stores the player's monsters
var enemy_team: Array = []   # Stores the enemy monsters

func start_combat(player_team: Array, enemy_team: Array):
	# Combine player and enemy teams into a single array
	combatants = player_team + enemy_team
	
	# Roll initiative for each combatant
	for combatant in combatants:
		combatant.initiative = roll_initiative(combatant)
		combatant.is_flat_footed = true  # All combatants start flat-footed
	
	# Sort combatants by initiative
	sort_combatants_by_initiative()
	
	# Start the first turn
	start_turn()

func roll_initiative(combatant: Monster) -> int:
	# Roll a d20 and add Dexterity modifier
	return roll_dice(1, 20, combatant.init_mod)

func roll_dice(num_dice: int, num_sides: int, modifier: int) -> int:
	var total = 0
	for i in range(num_dice):
		total += randi() % num_sides + 1  # Roll a die and add to the total
	return total + modifier

func sort_combatants_by_initiative():
	# Sort combatants by initiative (highest first)
	combatants.sort_custom(func(a, b): 
		if a.initiative == b.initiative:
			# If initiative is tied, sort by Dexterity modifier (highest first)
			if a.init_mod== b.init_mod:
				# If Dexterity modifier is tied, roll to break the tie
				return randf() < 0.5
			else:
				return a.init_mod > b.init_mod
		else:
			return a.initiative > b.initiative
	)
	
	# Update turn order
	turn_order = combatants

func start_turn():
	var current_combatant = turn_order[current_turn_index]
	print("It's " + current_combatant.monster_name + "'s turn!")
	
	# Handle flat-footed status
	if current_combatant.is_flat_footed:
		current_combatant.is_flat_footed = false
		print(current_combatant.monster_name + " is no longer flat-footed!")
	
	# Handle the combatant's turn
	if current_combatant in player_team:
		handle_player_turn(current_combatant)
	else:
		handle_ai_turn(current_combatant)

func handle_player_turn(combatant: Monster):
	# Wait for player input (e.g., attack, use ability)
	print("Waiting for player input...")

func handle_ai_turn(combatant: Monster):
	# AI logic (e.g., choose a target and attack)
	print("AI is taking its turn...")
	end_turn()

func end_turn():
	# Move to the next combatant in the turn order
	current_turn_index = (current_turn_index + 1) % turn_order.size()
	
	# Start the next turn
	start_turn()

func end_combat():
	# Check for victory/defeat
	if player_team.is_empty():
		print("Player defeated!")
	elif enemy_team.is_empty():
		print("Player victorious!")
	else:
		print("Combat ended in a draw.")
