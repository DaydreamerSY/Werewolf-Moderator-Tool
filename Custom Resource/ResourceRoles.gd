extends Resource
class_name ResourceRoles

signal list_changed(list, )

@export var roles_list : Dictionary = {"list": []}

var roles_list_default : Dictionary = {"list": [
	{"name":"Villager","selected": false},
	{"name":"Werewolf","selected": false},
	{"name":"Bodyguard","selected": false},
	{"name":"Seer","selected": false},
	{"name":"Tanner","selected": false},
	{"name":"Cupid","selected": false},
	{"name":"Hunter","selected": false},
	{"name":"Lycan","selected": false},
	{"name":"Mason","selected": false},
	{"name":"Minion","selected": false},
	{"name":"Witch","selected": false},
	{"name":"Mayor","selected": false},
	{"name":"Alpha Wolf","selected": false},
	{"name":"Apprentice Seer","selected": false},
	{"name":"Arsonist","selected": false},
	{"name":"Baker","selected": false},
	{"name":"Big Bad Wolf","selected": false},
	{"name":"Bloody Mary","selected": false},
	{"name":"Chef","selected": false},
	{"name":"Confused Wolf","selected": false},
	{"name":"Doctor","selected": false},
	{"name":"Doppelgänger","selected": false},
	{"name":"Drunk Villager","selected": false},
	{"name":"Enchantress","selected": false},
	{"name":"Executioner","selected": false},
	{"name":"Fallen Angel","selected": false},
	{"name":"Fool","selected": false},
	{"name":"Fruit Brute","selected": false},
	{"name":"Guardian Angel","selected": false},
	{"name":"Insomniac","selected": false},
	{"name":"Lone Wolf","selected": false},
	{"name":"Mad Scientist","selected": false},
	{"name":"Moderator","selected": false},
	{"name":"Mystic Wolf","selected": false},
	{"name":"Old man","selected": false},
	{"name":"Omega Wolf","selected": false},
	{"name":"Poisoner","selected": false},
	{"name":"Priest","selected": false},
	{"name":"Red Lady","selected": false},
	{"name":"Remorseful Wolf","selected": false},
	{"name":"Servant","selected": false},
	{"name":"Sorcerer","selected": false},
	{"name":"Soviet","selected": false},
	{"name":"Spy","selected": false},
	{"name":"Time Lord","selected": false},
	{"name":"Turncoat","selected": false},
	{"name":"Vengeful ghost","selected": false},
	{"name":"Wolf Cub","selected": false},
]}


const SAVE_FILE = "user://roles_list.json"

func _reset():
	roles_list = roles_list_default.duplicate(true)
	emit_signal("list_changed", roles_list["list"])




# GET funcs

func _get_size():
	return roles_list["list"].size()

func _get_list():
	return roles_list["list"]




# SET funcs

func _trigger_select(name):
	for role in roles_list["list"]:
		if role["name"] == name:
			role["selected"] = !role["selected"]
			print("change active to " + str(role["selected"]))
			break
	_save_data()
	emit_signal("list_changed", roles_list["list"])
	




# SAVE / LOAD	
func _save_data():
	var file = File.new()
	file.open(SAVE_FILE, File.WRITE)
	file.store_line(JSON.new().stringify(roles_list))
	file.close()

func _create_data():
	var file = File.new()
	file.open(SAVE_FILE, File.WRITE)
	file.store_line(JSON.new().stringify(roles_list_default))
	file.close()

func _load_data():
	var file = File.new()
	if not file.file_exists(SAVE_FILE):
		_create_data()
	
	file.open(SAVE_FILE, File.READ)
	var test_json_conv = JSON.new()
	test_json_conv.parse(file.get_as_text())
	roles_list = test_json_conv.get_data()
	
	file.close()
	emit_signal("list_changed", roles_list["list"])
