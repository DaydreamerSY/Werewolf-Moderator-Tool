extends Control


@export var list_role_element_scence : PackedScene
@export var roles_list : Resource

signal item_pressed(id, )

var navigator
var grid_container
var page_label

var page = 0
var start_page = 0
var end_page = 0
var max_per_page = 12

var is_open_1st = true

func _ready():
	navigator = get_node("Navigator")
	grid_container = get_node("GridContainer")
	page_label = navigator.get_node("Label")
	
	roles_list._load_data()
	_load_list()
	is_open_1st = false
	
	# connect catch signal when change player list to func on_change
	roles_list.connect("list_changed",Callable(self,"_on_list_change"))
	pass


func _create_item_on_list(name, is_trigger):
	var btnRoleN = list_role_element_scence.instantiate()
#	btnRoleN.set_position(Vector2(posx, posy))
	btnRoleN.get_node("Role").text = name
	btnRoleN.connect("pressed",Callable(self,"_on_list_element_pressed").bind(btnRoleN))
	grid_container.add_child(btnRoleN) 
	if is_trigger:
		btnRoleN._trigger_select()
		print("creat role with True mark")


func _load_list():
	page_label.text = str(page)
	
	
	var list = roles_list._get_list()
	var size = list.size()
	
	print("\nSize: " + str(size))
	
	if is_open_1st:
		if size > max_per_page:
			print("go this fist")
			navigator.visible = true
			end_page = max_per_page
		else:
			print("go this second")
			end_page = size
			navigator.visible = false

	print("Page: " + str(page))
	print("Start page: " + str(start_page))
	print("End page: " + str(end_page))
		
	for i in range(start_page, end_page):
		var btnRoleN = list_role_element_scence.instantiate()
		_create_item_on_list(list[i]["name"], list[i]["selected"])


func _on_list_change(new_list):
	_delete_children()
	
	var size = new_list.size()

	if size > max_per_page:
		navigator.visible = true
		if max_per_page * (page + 1) < size:
			end_page = max_per_page * (page + 1)
		else:
			end_page = size
	else:
		navigator.visible = false

	if size == max_per_page:
		page = 1
		page_label.text = str(page)
		start_page = 0
		end_page = max_per_page
		
	if size < max_per_page:
		end_page = size

	for i in range(start_page, end_page):
		var btnRoleN = list_role_element_scence.instantiate()
		_create_item_on_list(new_list[i]["name"], new_list[i]["selected"])


func _on_list_element_pressed(btnRoleN):
	print("Role: " + btnRoleN.get_node("Role").text)
	print("Selected: " + str(btnRoleN.get_node("Sprite2D").visible))
	print("")
	btnRoleN._trigger_select()
	roles_list._trigger_select(btnRoleN.get_node("Role").text)
	emit_signal("item_pressed", btnRoleN.get_node("Role").text)
	pass

func _delete_children():
	for n in grid_container.get_children():
		grid_container.remove_child(n)
		n.queue_free()

func _on_Prev_pressed():
	var size = roles_list._get_list().size()
	if page > 0:
		page -= 1
		start_page = max_per_page * page
		end_page = max_per_page * (page + 1)
		
		_delete_children()
		_load_list()




func _on_Next_pressed():
	var size = roles_list._get_list().size()
	
	if page < (size / max_per_page):
		page += 1
		start_page = max_per_page * page
		
		if max_per_page * (page + 1) < size:
			end_page = max_per_page * (page + 1)
		else:
			end_page = size
	
	_delete_children()
	_load_list()
