extends TextureButton


var default_color

func _ready():
	default_color = self_modulate
	pass # Replace with function body.


func _on_button_button_down():
	self_modulate = Color.GRAY


func _on_button_button_up():
	self_modulate = default_color


func _on_Prev_button_down():
	self_modulate = Color.GRAY


func _on_Prev_button_up():
	self_modulate = default_color


func _on_Next_button_down():
	self_modulate = Color.GRAY


func _on_Next_button_up():
	self_modulate = default_color


func _on_btnAddPlayerExit_button_down():
	self_modulate = Color.GRAY


func _on_btn_add_player_button_down():
	self_modulate = Color.GRAY


func _on_btn_add_player_button_up():
	self_modulate = default_color


func _on_btn_ok_button_down():
	self_modulate = Color.GRAY


func _on_btn_ok_button_up():
	self_modulate = default_color
