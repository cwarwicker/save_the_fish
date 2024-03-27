extends Node2D

@onready var score = $Score
@onready var music = $BackgroundMusic

func _ready():
	music.play()

func game_over():
	get_tree().change_scene_to_file("res://end_screen.tscn")
	pass
