extends Control

export (Resource) var player_list

signal isOpen(state,)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var player_id
var player_name = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_btnDelete_pressed():
	player_list._delete_player(player_id)
	print("Delete button is pressed with id: " + str(player_id))
	emit_signal("isOpen", false)
	get_node("LineEdit").clear()


func _on_btnUpdate_pressed():
	player_list._set_name(player_id, get_node("LineEdit").get_text())
	emit_signal("isOpen", false)
	get_node("LineEdit").clear()


func _on_Interface_item_id(id):
	player_id = id
	if player_list._get_name_from_id(player_id) == null:
		return
	get_node("LineEdit").text = player_list._get_name_from_id(player_id)
	


func _on_List_item_pressed(id):
	player_id = id
	if player_list._get_name_from_id(player_id) == null:
		return
	get_node("LineEdit").text = player_list._get_name_from_id(player_id)
