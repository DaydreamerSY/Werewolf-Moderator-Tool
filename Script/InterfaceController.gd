extends Control

signal item_id(id, )

var popupAddPlayer
var popupUpdatePlayer

var btnAddPlayer
var btnRoles
var btnBegin

# Called when the node enters the scene tree for the first time.
func _ready():
	# pop up and more
	popupAddPlayer = $"../../../Popup/Popup Add Player"
	popupUpdatePlayer = $"../../../Popup/Popup Update Player"
	
	# interface button
	btnAddPlayer = $"../btnAddPlayer"
	pass # Replace with function body.


func _on_btnAddPlayer_pressed():
	popupAddPlayer.visible = true
#	btnAddPlayer.disabled = true


func _on_btnCancel_pressed():
	popupAddPlayer.visible = false
#	btnAddPlayer.disabled = false


func _on_Popup_Add_Player_isOpen(state):
	popupAddPlayer.visible = false


func _on_List_item_pressed(id):
	popupUpdatePlayer.visible = true
	emit_signal("item_id", id)


func _on_Popup_Update_Player_isOpen(state):
	popupUpdatePlayer.visible = false



func _on_btnAddPlayerExit_pressed():
	popupAddPlayer.visible = false


func _on_btnUpdatePlayerExit_pressed():
	popupUpdatePlayer.visible = false



