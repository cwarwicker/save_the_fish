extends Node

var round = 0
var left = 0
var interval = 0
var timer = null

var dying_fish = preload("res://DyingFish.tscn")

@onready var jump_sound = $"../JumpSound"
@onready var round_text = $"../Round"
@onready var tank_sprite = $"../Tank/Sprite2D"

# Called when the node enters the scene tree for the first time.
func _ready():
	calculate()	
	run()


func calculate():
	left = calculate_total(round)
	interval = calculate_spawn_interval(left)	

func run():
	
	# Are there any left? If not, we need to recalculate.
	if left <= 0:
		round += 1
		round_text.text = "Round: " + str(round + 1)
		calculate()
		timer.wait_time = interval
	
	# Create a timer with the specified interval.
	if timer == null:
		timer = Timer.new()
		add_child(timer)
		timer.autostart = false
		timer.wait_time = interval
		timer.timeout.connect(_on_timer_timeout)

	# Start/restart the timer.
	timer.start()


	
	
func _on_timer_timeout():
		
	# Spawn the fish.
	spawn()

	
func spawn():
	
	# Get window width and pick a random position to spawn the fish.
	var width = get_viewport().get_visible_rect().size.x
	var pos = (width / 2) + RandomNumberGenerator.new().randi_range(-250, 250)
	
	# Instantiate the scene node and add to the main game scene.
	var instance = dying_fish.instantiate()
	instance.position = Vector2(pos,0)
	var rigidbody = instance.get_child(0)
	rigidbody.linear_velocity.x = RandomNumberGenerator.new().randi_range(-500, 500)
	rigidbody.linear_velocity.y = RandomNumberGenerator.new().randi_range(-250, -50)
	get_tree().get_root().get_node("game").add_child(instance)
	
	# Play the spawning sound.
	jump_sound.play()
	
	# Decrement the fish left to spawn in this round.
	left -= 1
	
	# Then run it again to queue the next timer.
	run()


func calculate_total(round):
	return 10 + (10 * round)

func calculate_spawn_interval(total):
	# Given the total number of spawns, and each round being 60 seconds, how often do we need to spawn one?
	return float(30) / float(total)
