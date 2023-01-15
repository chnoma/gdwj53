extends Node

var action_name = "NOT SET"
var bind = "NOT SET"

signal rebind_request(action, ui_element)

# Called when the node enters the scene tree for the first time.
func _ready():
	$ActionName.text = action_name
	$BindButton.text = bind


func _on_BindButton_pressed():
	emit_signal("rebind_request", action_name, self)

func set_bind(new_bind):
	bind = new_bind
	$BindButton.text = bind

func set_is_rebinding(state):
	if state:
		$BindButton.text = "Press any key..."
	else:
		$BindButton.text = bind
