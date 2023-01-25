extends Control

@export var player_list : Resource

signal isOpen(state,)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var player_name = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_btn_ok_pressed():
	player_name = get_node("LineEdit").get_text()
	player_list._add_player(player_name)
	self.visible = false
	emit_signal("isOpen", false)
	get_node("LineEdit").clear()
	pass # Replace with function body.
