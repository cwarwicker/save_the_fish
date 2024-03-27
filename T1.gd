extends Label

@onready var tutorial = $"../.."
@onready var spawn_manager = $"../../SpawnManager"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_visibility_changed():
	
	# If we just showed this, spawn a fish.
	if (visible):
		
		await get_tree().create_timer(2).timeout
		spawn_manager.spawn()
		
		await get_tree().create_timer(2).timeout
		tutorial.show_next_text()
