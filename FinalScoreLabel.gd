extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	text = text.replace("<score>", str(PlayerData.score))

