extends TextureRect

@onready var plop_sound = $"../PlopSound"
@onready var tutorial = $".."

func toggle_drop_area(v):
	visible = v

# What to do when hovered over the drop area.	
func _can_drop_data(at_position, data):
	visible = true
	return true
	
# What to do when dropped there.	
func _drop_data(at_position, data):
		
	# Remove the draggable fish from the scene.
	data['node'].get_parent().get_parent().queue_free()
	
	# Hide the panel.
	toggle_drop_area(false)
	
	# Play the sound.
	plop_sound.play()

	# Show next text.
	tutorial.show_next_text(4)
	
