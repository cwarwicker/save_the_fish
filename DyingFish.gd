extends Node2D

signal game_over

const LIFE_TIME = 10

var timer = null
var time_left = LIFE_TIME
var health_width = null
var is_tutorial = false

@onready var sprite = $DraggableNode/sprite
@onready var health = $DraggableNode/sprite/Health

# Called when the node enters the scene tree for the first time.
func _ready():
	
	health_width = health.size.x
	
	# Play its animation.
	sprite.play("flop")
	
	# Start decaying.
	decay()
	
func decay():
	
	if (timer == null):
		timer = Timer.new()
		add_child(timer)
		timer.autostart = false
		timer.wait_time = 1
		timer.timeout.connect(_on_timer_timeout)

	timer.start()
	
	# Reduce the width of the health bar.
	var percent_left = (float(time_left) / float(LIFE_TIME)) * 100
	var width = (float(health_width) / float(100)) * percent_left
	health.size.x = width
	
func _on_timer_timeout():
	
	time_left -= 1
	
	if (time_left < 0):
		emit_signal("game_over")
	else:
		decay()	
		

func _on_game_over():
	if (not is_tutorial):
		get_tree().get_root().get_node("game").game_over()
