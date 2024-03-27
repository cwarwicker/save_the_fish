extends AnimatedSprite2D

func _ready():
	play("flop")

func _process(delta):
	
	# Set the position of the preview to our mouse position.
	global_position = get_global_mouse_position()
	
	# Remove the preview when we release the mouse again.
	if Input.is_action_just_released("mb"):
		queue_free()
