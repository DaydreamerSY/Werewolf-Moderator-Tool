extends TextureButton


var default_color


func _ready():
	default_color = self_modulate
	$Sprite.visible = false

func _on_List_Element_button_down():
	self_modulate = Color.gray


func _on_List_Element_button_up():
	self_modulate = default_color


func _trigger_select():
	$Sprite.visible = !$Sprite.visible
