extends Monster


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var criosphinx = JsonLoader.load_monster("res://data/monsters/Criosphinx.json",self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
