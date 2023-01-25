extends TextureButton


var default_color


func _ready():
	default_color = self_modulate
	$Sprite2D.visible = false

func _on_List_Element_button_down():
	self_modulate = Color.GRAY


func _on_List_Element_button_up():
	self_modulate = default_color


func _trigger_select():
	$Sprite2D.visible = !$Sprite2D.visible
