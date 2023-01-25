extends Node

signal scene_changed(scene_name)

@export
var scene_name : String = "Home"

var swipe_start = null
var minimum_drag = 20

var is_finger_pressed
var event_position_x 

var screen_amount_min = 1
var screen_amount_max = 3
var current_screen = 1

var is_moving = false

var menu
var man

var move_speed = 0.5

var title_text_default = "SET UP"
var title_text_letgo = "LET GO!!"

func _ready():
	menu = get_node("Menu")
	man = get_node("Step/Man")
	pass
	

func _input(event):
	if event is InputEventScreenTouch:
		if is_moving:
			return
		if event.pressed:
			swipe_start = event.get_position()
		else:
			_calculate_swipe(event.get_position())


func _calculate_swipe(swipe_end):
	if swipe_start == null: 
		return
	var swipe = swipe_end - swipe_start
	if abs(swipe.x) > minimum_drag:
		if swipe.x > 0:
			print("swipe to right so screen should move to left " + str(current_screen))
			move_left()
		else:
			print("swipe to left so screen should move to right " + str(current_screen))
			move_right()

func move_left():
	if current_screen > screen_amount_min:
		is_moving = true
		var TW = create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
		TW.tween_property(menu, "position:x", 
			menu.position.x + 1080.0, move_speed)
		TW.parallel().tween_property(man, "position:x",
			man.position.x - 400, move_speed)
		TW.tween_callback(Callable(self,"_set_false_is_moving"))
		current_screen -= 1
		
	if current_screen == screen_amount_max:
		$Title/Label.text = title_text_letgo
	else:
		$Title/Label.text = title_text_default

func move_right():
	if current_screen < screen_amount_max:
		is_moving = true
		var TW = create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
		TW.tween_property(menu, "position:x", 
			menu.position.x - 1080.0, move_speed)
		TW.parallel().tween_property(man, "position:x",
			man.position.x + 400, move_speed)
		TW.tween_callback(Callable(self,"_set_false_is_moving"))
		current_screen += 1
	
	if current_screen == screen_amount_max:
		$Title/Label.text = title_text_letgo
	else:
		$Title/Label.text = title_text_default

func _set_false_is_moving():
	print("set false moving")
	is_moving = false


func _on_begin_night_pressed():
	emit_signal("scene_changed", scene_name)
	print("Emited signal")
