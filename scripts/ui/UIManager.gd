extends Control

# Primary buttons
@onready var combat_maneuvers_button = $PrimaryButtonsContainer/CombatManueversButton
@onready var full_round_action_button = $PrimaryButtonsContainer/FullRoundActionButton
@onready var move_action_button = $PrimaryButtonsContainer/MoveActionButton
@onready var standard_action_button = $PrimaryButtonsContainer/StandardActionButton
@onready var free_action_button = $PrimaryButtonsContainer/FreeActionButton
@onready var five_foot_step_button = $PrimaryButtonsContainer/FiveFootStepButton
@onready var attack_opportunity_button = $PrimaryButtonsContainer/AttackOppurtunityButton
@onready var swift_action_button = $PrimaryButtonsContainer/SwiftActionButton

func show_ui():
	visible = true

func hide_ui():
	visible = false

func _ready():
	# Connect primary buttons to their signal handlers
	combat_maneuvers_button.pressed.connect(_on_CombatManueversButton_pressed)
	full_round_action_button.pressed.connect(_on_FullRoundActionButton_pressed)
	move_action_button.pressed.connect( _on_MoveActionButton_pressed)
	standard_action_button.pressed.connect(_on_StandardActionButton_pressed)
	free_action_button.pressed.connect(_on_FreeActionButton_pressed)
	five_foot_step_button.pressed.connect(_on_FiveFootStepButton_pressed)
	attack_opportunity_button.pressed.connect(_on_AttackOppurtunityButton_pressed)
	swift_action_button.pressed.connect(_on_SwiftActionButton_pressed)

func _on_CombatManueversButton_pressed():
	print("Combat Maneuvers button pressed!")

func _on_FullRoundActionButton_pressed():
	print("Full Round Action button pressed!")
	
func _on_MoveActionButton_pressed():
	print("Move Action Button pressed")
	
func _on_StandardActionButton_pressed():
	print("Standard Action Button Pressed")

func _on_FreeActionButton_pressed():
	print("Free Action Button Pressed")

func _on_FiveFootStepButton_pressed():
	print("5 Foot Step Button Pressed")
	
func _on_AttackOppurtunityButton_pressed():
	print ("Attack of oppurtunity button pressed")

func _on_SwiftActionButton_pressed():
	print ("Swift Action Button Pressed")

func update_buttons(actions):
	pass
	
# Add similar functions for other buttons
