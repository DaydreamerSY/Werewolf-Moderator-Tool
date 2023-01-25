extends Control

@export var list_element_scence : PackedScene
@export var player_list : Resource

signal item_pressed(id, )

var navigator
var grid_container
var page_label

var page = 0
var start_page = 0
var max_per_page = 12
var end_page = 0

var is_open_1st = true

func _ready():
	navigator = get_node("Navigator")
	grid_container = get_node("GridContainer")
	page_label = navigator.get_node("Label")
	
	player_list._load_data()
	_load_list()
	
	is_open_1st = false
	
	# connect catch signal when change player list to func on_change
	player_list.connect("list_changed",Callable(self,"_on_list_change"))
	pass 
	
	
func _create_item_on_list(player_name, id):
	var _btnRoleN = list_element_scence.instantiate()
#	_btnRoleN.set_position(Vector2(posx, posy))
	_btnRoleN.get_node("Name").text = player_name
	_btnRoleN.get_node("Id").text = str(id)
	_btnRoleN.connect("pressed",Callable(self,"_on_list_element_pressed").bind(_btnRoleN))
	grid_container.add_child(_btnRoleN)


func _load_list():
	page_label.text = str(page + 1)
	
	
	var list = player_list._get_list()
	var _size = list.size()
	
	print("\nSize: " + str(_size))
	
	if is_open_1st:
		if _size > max_per_page:
			print("go this fist")
			navigator.visible = true
			end_page = max_per_page
		else:
			print("go this second")
			end_page = _size
			navigator.visible = false
		
	
	print("Page: " + str(page))
	print("Start page: " + str(start_page))
	print("End page: " + str(end_page))
		
	for i in range(start_page, end_page):
		var _btnRoleN = list_element_scence.instantiate()
		_create_item_on_list(list[i]["name"], list[i]["id"])



func _on_list_change(new_list):
	_delete_children()

	var _size = new_list.size()

	if _size > max_per_page:
		navigator.visible = true
		if max_per_page * (page + 1) < _size:
			end_page = max_per_page * (page + 1)
		else:
			end_page = _size
	else:
		navigator.visible = false

	if _size == max_per_page:
		page = 1
		page_label.text = str(page + 1)
		start_page = 0
		end_page = max_per_page
		
	if _size < max_per_page:
		end_page = _size

	for i in range(start_page, end_page):
		var _btnRoleN = list_element_scence.instantiate()
		_create_item_on_list(new_list[i]["name"], new_list[i]["id"])



func _delete_children():
	for n in grid_container.get_children():
		grid_container.remove_child(n)
		n.queue_free()



func _on_list_element_pressed(btnPlayer):
	print("ID: " + btnPlayer.get_node("Id").text)
	print("Namme: " + btnPlayer.get_node("Name").text)
	print("")
	emit_signal("item_pressed", btnPlayer.get_node("Id").text)
	pass



func _on_Prev_pressed():
	if page > 0:
		page -= 1
		start_page = max_per_page * page
		end_page = max_per_page * (page + 1)
		
		_delete_children()
		_load_list()




func _on_Next_pressed():
	var _size = player_list._get_list().size()
	
	if page < (_size / max_per_page):
		page += 1
		start_page = max_per_page * page
		
		if max_per_page * (page + 1) < _size:
			end_page = max_per_page * (page + 1)
		else:
			end_page = _size
	
	_delete_children()
	_load_list()


func _on_btnAddPlayer_pressed():
	$"../../Popup/Popup Add Player".visible = true
