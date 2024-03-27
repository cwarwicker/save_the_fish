extends CharacterBody2D

class_name Fish

const SPEED = 100

var is_moving = false
var move_direction = 0
var timer

@export var sprite : AnimatedSprite2D
@export var can_move : bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.play("swim")

func _physics_process(delta):
	
	if (not can_move):
		return
		
	# If we are not doing a movement, pick a new one.
	if (not is_moving):
		change_direction(delta)
	else:
		# Got a direction, so now we can start moving.
		move(delta)	
		
	# Check for collisions with the sides of the tank.
	for index in get_slide_collision_count():
		var collision = get_slide_collision(index)
		var body = collision.get_collider()
		
		# Fishy hit the tank, change direction.
		if body.name == "Tank":
			if (move_direction == 1):
				move_direction = -1
			else:
				move_direction = 1
	
func move(delta):
		
	# If we are moving right, flip the sprite.
	if (move_direction == 1):
		sprite.flip_h = true
	elif (move_direction == -1):
		sprite.flip_h = false		
	
	velocity.x = SPEED * move_direction
	move_and_slide()
	
	# If fishy is staying still, stop the animation.
	if (move_direction == 0):
		sprite.stop()
	else:
		sprite.play("swim")		
	
func stop():
	is_moving = false
	move_direction = 0	
	
func change_direction(delta):
		
	# Pick a random direction to move in (left or right).
	move_direction = RandomNumberGenerator.new().randi_range(-1, 1)
	is_moving = true
	
	# Pick how long they should move in that direction for.
	var length = RandomNumberGenerator.new().randi_range(2, 5)
	
	# Start a timer to choose another direction.
	timer = get_tree().create_timer(length)
	await timer.timeout
	stop()


