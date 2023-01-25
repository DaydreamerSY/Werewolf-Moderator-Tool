extends TextureButton


var default_color


func _ready():
	default_color = self_modulate

func _on_List_Element_button_down():
	self_modulate = Color.GRAY


func _on_List_Element_button_up():
	self_modulate = default_color
