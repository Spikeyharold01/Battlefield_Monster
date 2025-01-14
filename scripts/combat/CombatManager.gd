extends Node
class_name CombatManager

# References to the UI and combatants
var ui
var combat_scene: Node3D  # Reference to the 3D scene
var turn_order: Array = []
var current_turn_index: int = 0
var combatants: Array = []
var player_team: Array = []
var enemy_team: Array = []

func set_ui(ui_node):
	ui = ui_node

func set_combat_scene(scene: Node3D):
	combat_scene = scene

func start_combat(player_team: Array, enemy_team: Array):
	self.player_team = player_team
	self.enemy_team = enemy_team
	combatants = player_team + enemy_team

	# Position player team on one side of the battlefield
	for i in range(player_team.size()):
		player_team[i].combat_position = Vector3(i * 2, 0, 0)
		var scene_instance = player_team[i].load_scene()
		if scene_instance:
			scene_instance.position = player_team[i].combat_position
			combat_scene.add_child(scene_instance)

	# Position enemy team on the other side
	for i in range(enemy_team.size()):
		enemy_team[i].combat_position = Vector3(i * 2, 0, 10)
		var scene_instance = enemy_team[i].load_scene()
		if scene_instance:
			scene_instance.position = enemy_team[i].combat_position
			combat_scene.add_child(scene_instance)

	# Roll initiative and sort combatants
	for combatant in combatants:
		combatant.initiative = roll_initiative(combatant)
		combatant.is_flat_footed = true

	sort_combatants_by_initiative()
	start_turn()

func roll_initiative(combatant: Monster) -> int:
	return roll_dice(1, 20, combatant.init_mod)

func roll_dice(num_dice: int, num_sides: int, modifier: int) -> int:
	var total = 0
	for i in range(num_dice):
		total += randi() % num_sides + 1
	return total + modifier

func sort_combatants_by_initiative():
	combatants.sort_custom(func(a, b): 
		if a.initiative == b.initiative:
			if a.init_mod == b.init_mod:
				return randf() < 0.5
			else:
				return a.init_mod > b.init_mod
		else:
			return a.initiative > b.initiative
	)
	turn_order = combatants

func start_turn():
	var current_combatant = turn_order[current_turn_index]
	print("It's " + current_combatant.monster_name + "'s turn!")
	update_ui_for_turn(current_combatant, player_team)
	if current_combatant in player_team:
		handle_player_turn(current_combatant)
	else:
		handle_ai_turn(current_combatant)

func handle_player_turn(combatant: Monster):
	print("Waiting for player input...")

func handle_ai_turn(combatant: Monster):
	print("AI is taking its turn...")
	end_turn()

func end_turn():
	current_turn_index = (current_turn_index + 1) % turn_order.size()
	if player_team.is_empty() or enemy_team.is_empty():
		end_combat()
	else:
		start_turn()

func end_combat():
	if player_team.is_empty():
		print("Player defeated!")
	elif enemy_team.is_empty():
		print("Player victorious!")
	else:
		print("Combat ended in a draw.")

func update_ui_for_turn(current_combatant, players_team):
	if current_combatant in player_team:
		ui.show_ui()
		var actions = get_available_actions(current_combatant)
		ui.update_buttons(actions)  # Enable/disable buttons based on actions
	else:
		ui.hide_ui()

func get_available_actions(combatant: Monster) -> Array:
	var actions = []

	# Check for basic attack
	if has_line_of_sight(combatant, get_nearest_enemy(combatant)):
		actions.append("attack")

	# Check for spells or special abilities
	for skill in combatant.skills:
		if skill == "Fireball" and has_line_of_sight(combatant, get_nearest_enemy(combatant)):
			actions.append("cast_fireball")

	# Add movement if not flat-footed
	if not combatant.is_flat_footed:
		actions.append("move")

	return actions

func has_line_of_sight(combatant: Monster, target: Monster) -> bool:
	if combat_scene:
		var space_state = combat_scene.get_world_3d().direct_space_state
		var ray_params = PhysicsRayQueryParameters3D.new()
		ray_params.from = combatant.combat_position
		ray_params.to = target.combat_position
		var result = space_state.intersect_ray(ray_params)
		return result.is_empty()  # No obstacles in the way
	return false  # Default to false if combat_scene is not set

func get_nearest_enemy(combatant: Monster) -> Monster:
	var nearest_enemy = null
	var min_distance = INF
	for enemy in enemy_team if combatant in player_team else player_team:
		var distance = combatant.combat_position.distance_to(enemy.combat_position)
		if distance < min_distance:
			min_distance = distance
			nearest_enemy = enemy
	return nearest_enemy
