extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var TW = create_tween()
	TW.tween_property($MovePoint, "position:x", 
		-1080.0, 2).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
