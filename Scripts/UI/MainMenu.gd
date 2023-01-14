extends Node

var ui_options = preload("res://Scenes/UI/OptionsMenu.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	$HBoxContainer/VBoxContainer/StartButton.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_QuitButton_button_up():
	GlobalSettings.exit()


func _on_OptionsButton_button_up():
	var options_menu = ui_options.instance()
	add_child(options_menu)
