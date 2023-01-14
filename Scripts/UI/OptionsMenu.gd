class_name OptionsMenu
extends MarginContainer

#  references https://www.gotut.net/godot-key-bindings-tutorial/ heavily

const ui_binding = preload("res://Scenes/UI/Elements/ControlBind.tscn")

var action_ui_binding = {}
var state_rebinding = false
var selected_action = null

func _ready():
	for action in InputMap.get_actions():
		if !("ui_" in action):
			var new_binding = ui_binding.instance()
			new_binding.action_name = action
			new_binding.bind = InputMap.get_action_list(action)[0].as_text()
			$MainVBox/BindingScrollContainer/Background/BindingVBox.add_child(new_binding)
			new_binding.connect("rebind_request", self, "_on_rebind_request")
			action_ui_binding[action] = new_binding
	$MainVBox/VBoxContainer/VBoxContainer/HBoxContainer/volume_master_slider.value = GlobalSettings.volume_master
	$MainVBox/VBoxContainer/VBoxContainer/HBoxContainer2/volume_sfx_slider.value = GlobalSettings.volume_sfx
	$MainVBox/VBoxContainer/VBoxContainer/HBoxContainer3/volume_music_slider.value = GlobalSettings.volume_music

func _input(event):
	if state_rebinding:
		if event is InputEventKey:
			if event.scancode != KEY_ESCAPE:
				GlobalSettings.set_keybind(selected_action, event)
				action_ui_binding[selected_action].set_bind(event.as_text())
			action_ui_binding[selected_action].set_is_rebinding(false)
			state_rebinding = false

func _on_rebind_request(action, bind_ui): # TODO: deselect all other rebind buttons
	selected_action = action
	state_rebinding = true
	bind_ui.set_is_rebinding(true)

func _on_MainMenu_button_up():
	GlobalSettings.save_config()
	queue_free()

func _on_volume_master_slider_value_changed(value):
	GlobalSettings.volume_master = value

func _on_volume_sfx_slider_value_changed(value):
	GlobalSettings.volume_sfx = value

func _on_volume_music_slider_value_changed(value):
	GlobalSettings.volume_music = value
