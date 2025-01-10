extends Monster


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var catoblepas = JsonLoader.load_monster("res://data/monsters/Catoblepas.json")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
