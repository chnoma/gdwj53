extends Node

var config_path: String = "res://config.ini"

var bind_aliases = {"move_left": "ui_left",
				"move_up": "ui_up",
				"move_down": "ui_down",
				"move_right": "ui_right"}

var user_id = OS.get_unique_id()
var config = ConfigFile.new()

# configurable parameters
var volume_master = null setget set_volume_master, get_volume_master
var volume_sfx = null setget set_volume_sfx, get_volume_sfx
var volume_music = null setget set_volume_music, get_volume_music

func _ready() -> void:
	if config.load(config_path) == OK:
		if config.has_section("input"):
			for action in config.get_section_keys("input"):
				set_keybind(action, config.get_value("input", action))
	else:
		set_volume_master()
		set_volume_sfx()
		set_volume_music()
		save_config()

func clear_keybind(action) -> void:
	if !InputMap.get_action_list(action).empty():
		for binding in InputMap.get_action_list(action):
			InputMap.action_erase_event(action, binding)
	if action in bind_aliases.keys():
		var aliased_action = bind_aliases[action]
		clear_keybind(aliased_action)

func set_keybind(action, key, clear_binding=true) -> void:  # TODO: deconflict with existing binds
	#remove default keybinds
	if clear_binding:
		clear_keybind(action)
	if action in bind_aliases.keys():
		var aliased_action = bind_aliases[action]
		set_keybind(aliased_action, key, false)
	InputMap.action_add_event(action, key)
	config.set_value("input", action, key)

func save_config() -> void:
	config.save(config_path)

func exit() -> void:
	save_config()
	get_tree().quit()

# gets a setting from the config -- if not set, set to default
func config_get_with_default(section: String, key: String, default):
	var return_value = config.get_value(section, key)
	if return_value == null:
		# if value is null, initialize value with default
		config.set_value(section, key, default)
		save_config()  # not the most optimized but w/e
		return default
	return return_value

# setters and getters
func get_volume_master() -> float:
	return config_get_with_default("audio", "volume_master", 1.0)
func set_volume_master(value: float = 1.0) -> void:
	config.set_value("audio", "volume_master", value)

func get_volume_sfx() -> float:
	return config_get_with_default("audio", "volume_sfx", 1.0)
func set_volume_sfx(value: float = 1.0) -> void:
	config.set_value("audio", "volume_sfx", value)

func get_volume_music() -> float:
	return config_get_with_default("audio", "volume_music", 1.0)
func set_volume_music(value: float = 1.0) -> void:
	config.set_value("audio", "volume_music", value)
