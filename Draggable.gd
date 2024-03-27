extends TextureRect

var is_being_dragged = false
var drag_preview = preload("res://drag_preview.tscn")
var root_scene = "game"
@onready var sprite = $"../sprite"

func toggle_drop_area(visible):
	print(root_scene + "/DropArea/Panel")
	get_tree().get_root().get_node(root_scene + "/DropArea/Panel").visible = visible

# Get the data when clicking to drag something.
func _get_drag_data(at_position):
	
	# Show the drop area panel.
	toggle_drop_area(true)
	
	# Hide the sprite on the original object.
	sprite.visible = false

	# We are dragging this node.
	is_being_dragged = true
	
	# Create the dict of data we want to transfer.
	var data = {}
	data['node'] = self
	
	# Create the preview to follow the mouse.
	# This instantiates the drag_preview node and adds it to the current scene.
	var preview = drag_preview.instantiate()
	add_child(preview)
	
	return data
	
	
func _notification(what):
	
	match what:
		
		# Notification type of a drag event ending.
		NOTIFICATION_DRAG_END:
			
			# If this node is being dragged.
			if is_being_dragged:
				
				# If we successfully dragged it to a droppable area, just delete it.
				if not is_drag_successful():
					
					# Hide the drop area again.
					toggle_drop_area(false)
					
					# Show the sprite on the original object.
					sprite.visible = true


