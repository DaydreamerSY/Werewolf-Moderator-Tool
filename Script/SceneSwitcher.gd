extends Control

@onready
var current_level_scene = $Home

func _ready():
	$Home.scene_changed.connect(_handle_scene_change)
	pass



func _handle_scene_change(current_level_name):
	var next_scene_name
	var next_scene
	
	match current_level_name:
		"Home":
			next_scene_name = "Night"
			print("Reach switcher")
		"Night":
			next_scene_name = "Home"
			print("Reach switcher")
		_:
			return
	
	next_scene = load("res://Scene/" + next_scene_name + ".tscn").instantiate()
	add_child(next_scene)
	next_scene.scene_changed.connect(_handle_scene_change)
	current_level_scene.queue_free()
	current_level_scene = next_scene

