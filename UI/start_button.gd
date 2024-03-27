extends Button

func _on_pressed():
	PlayerData.score = 0
	get_tree().change_scene_to_file("res://game.tscn")
