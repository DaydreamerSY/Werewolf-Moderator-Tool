extends Resource
class_name ResourceOrderRole


signal order_changed(order, )
var roles_list


@export var order : Dictionary = {"orders": []}

var order_default : Dictionary = {"orders": [
	{
		"order": "0",
		"name": "Werewolf",
		"num_target": "1",
		"call_at_1st_night": false
	},
]}

# GET SET funcs
func _set_active_roles():
	var active_role_list = _get_active_roles()
	for active_role in active_role_list["list"]:
		var is_exist = false
		for o in order["orders"]:
			if o["name"] == active_role["name"]:
				is_exist = true
				break
		
		if is_exist:
			continue
		
		order["orders"].append({ 
			"order": str(order["orders"].size()),
			"name": active_role["name"],
			"num_target": "",
			"call_at_1st_night": false
		})


func _get_order_list():
	return order["orders"]




const SAVE_FILE = "user://roles_order.json"
const ROLES_FILE = "user://roles_list.json"

func _reset():
	order = order_default.duplicate(true)
	emit_signal("order_changed", order["orders"])

# SAVE / LOAD	
func _save_data():
	var file = File.new()
	file.open(SAVE_FILE, File.WRITE)
	file.store_line(JSON.new().stringify(order))
	file.close()

func _create_data():
	var file = File.new()
	file.open(SAVE_FILE, File.WRITE)
	file.store_line(JSON.new().stringify(order_default))
	file.close()

func _load_data():
	var file = File.new()
	if not file.file_exists(SAVE_FILE):
		_create_data()
	
	file.open(SAVE_FILE, File.READ)
	var test_json_conv = JSON.new()
	test_json_conv.parse(file.get_as_text())
	order = test_json_conv.get_data()
	
	file.close()
	_load_role_list_data()
	_set_active_roles()
	emit_signal("order_changed", order["orders"])



func _load_role_list_data():
	var file = File.new()
	file.open(ROLES_FILE, File.READ)
	var test_json_conv = JSON.new()
	test_json_conv.parse(file.get_as_text())
	roles_list = test_json_conv.get_data()
	
	file.close()


func _get_active_roles():
	var active_list = {"list": []}
	for r in roles_list["list"]:
		if r["selected"]:
			active_list["list"].append(r)
	return active_list
