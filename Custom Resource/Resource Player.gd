extends Resource
class_name ResourcePlayers


signal list_changed(list, )



export var player_list : Dictionary = {"list": []}

var player_list_default : Dictionary = {"list": [
	{
		"id": "0",
		"name": "player 1"
	},
	{
		"id": "1",
		"name": "player 2"
	},
	{
		"id": "2",
		"name": "player 3"
	},
	{
		"id": "3",
		"name": "player 4"
	},
	{
		"id": "4",
		"name": "player 5"
	},
]}

const SAVE_FILE = "user://players_list.json"

func _reset():
	player_list = player_list_default.duplicate(true)
	emit_signal("list_changed", player_list["list"])




# GET funcs

func _get_size():
	return player_list["list"].size()

func _get_list():
	return player_list["list"]

func _get_name_from_id(id):
	for p in player_list["list"]:
		if p["id"] == id:
			return	p["name"]



# SET funcs

func _set_name(id, name):
	for player in player_list["list"]:
		if player["id"] == id:
			player["name"] = name
			break
	emit_signal("list_changed", player_list["list"])
	_save_data()


# UPDATE funcs

func _add_player(name):
	player_list["list"].append({
		"id": str(player_list["list"].size()),
		"name": name
	})
	_re_index_list()
	emit_signal("list_changed", player_list["list"])
	_save_data()

func _delete_player(id):
	for i in range(player_list["list"].size()):
		if player_list["list"][i]["id"] == id:
			player_list["list"].remove(i)
			break
	
	_re_index_list()
	emit_signal("list_changed", player_list["list"])
	_save_data()

func _re_index_list():
	for i in range(player_list["list"].size()):
		player_list["list"][i]["id"] = str(i)




# SAVE / LOAD	
func _save_data():
	var file = File.new()
	file.open(SAVE_FILE, File.WRITE)
	file.store_line(to_json(player_list))
	file.close()

func _create_data():
	var file = File.new()
	file.open(SAVE_FILE, File.WRITE)
	file.store_line(to_json(player_list_default))
	file.close()

func _load_data():
	var file = File.new()
	if not file.file_exists(SAVE_FILE):
		_create_data()
		return
	
	file.open(SAVE_FILE, File.READ)
	player_list = parse_json(file.get_as_text())
	
	file.close()
	
	emit_signal("list_changed", player_list["list"])

