extends Monster


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var taer = JsonLoader.load_monster("res://data/monsters/Taer.json",self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
