extends TextureRect

signal order_up(role_name,)
signal order_down(role_name,)

var role_name

func _ready():
	role_name = $labelRole.text

func _on_btn_order_up_pressed():
	emit_signal("order_up", role_name)
	print("order_up")


func _on_btn_order_down_pressed():
	emit_signal("order_down", role_name)
	print("order_down")
