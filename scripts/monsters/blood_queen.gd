extends Monster


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var bloodqueen = JsonLoader.load_monster("res://data/monsters/Blood_queen.json")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
