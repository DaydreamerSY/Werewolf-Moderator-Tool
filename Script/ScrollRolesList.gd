extends ScrollContainer

@export var role_element_scene : PackedScene
@export var role_list : Resource

var vbox

var start_point
var end_point

var x_valid = false
var y_valid = false

var pressed_start_point = Vector2(0,0)
var is_pressed = false

var role_order_list

func _ready():
	start_point = self.position
	var _size = self.size
	end_point = Vector2(start_point.x + _size.x, start_point.y + _size.y)
	print(start_point)
	print(end_point)
	vbox = $VBoxContainer
	role_list._load_data()
	role_order_list = role_list._get_order_list()
	_generate_list()
	role_list.order_changed.connect(_handle_order_changed)

func _process(delta):
#	self.scroll_vertical += 1
#	print(self.scroll_vertical)
	pass

func _input (event):
	if event is InputEventScreenTouch:
		if event.pressed:
			if start_point.x <= event.position.x && event.position.x <= end_point.x:
				x_valid = true
			else:
				x_valid = false
			
			if start_point.y <= event.position.y && event.position.y <= end_point.y:
				y_valid = true
			else:
				y_valid = false
			
			if x_valid && y_valid:
				pressed_start_point = Vector2(event.position.x, event.position.y)
			else:
				pressed_start_point = Vector2(0, 0)

	if event is InputEventScreenDrag:
		if x_valid && y_valid:
			#handle screen drag here
			self.scroll_vertical += pressed_start_point.y - event.position.y
			pass

func _create_item(role):
	var item = role_element_scene.instantiate()
	item.get_node("labelRole").text = role["order"] + ". " + role["name"]
	vbox.add_child(item)

func _delete_children():
	for n in vbox.get_children():
		vbox.remove_child(n)
		n.queue_free()

func _generate_list():
	_delete_children()
	for role in role_order_list:
		_create_item(role)

func _handle_order_changed(order_after_changed):
	role_list = order_after_changed
	role_order_list = role_list._get_order_list()
	_generate_list()
	pass
