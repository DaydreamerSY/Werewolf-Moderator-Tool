extends Control

signal scene_changed(scene_name)

@export
var scene_name : String = "Night"

var scroll_container


func _ready():
	pass


func _on_btn_exit_pressed():
	emit_signal("scene_changed", scene_name)


func _process(delta):
	pass


