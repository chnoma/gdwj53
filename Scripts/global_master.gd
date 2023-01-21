extends Node

enum ItemTypes {TRASH, REAR, MID, FRONT}

var ItemSuffix = {
	ItemTypes.FRONT: "front",
	ItemTypes.REAR: "rear",
	ItemTypes.MID: "mid",
	ItemTypes.TRASH: "trash"
}

var player = null

var level_object
var current_level_path

onready var rng = RandomNumberGenerator.new()

func set_bullet_time(bullettime):
	if bullettime:
		Engine.time_scale = 0.5
	else:
		Engine.time_scale = 1.0

func _ready():
	pass  # scrapped settings screen
# we do not care about these
# warning-ignore:return_value_discarded
	#GlobalSettings.connect("volume_master_changed", GlobalAudio, "set_master_volume")
# warning-ignore:return_value_discarded
	#GlobalSettings.connect("volume_sfx_changed", GlobalAudio, "set_sfx_volume")
# warning-ignore:return_value_discarded
	#GlobalSettings.connect("volume_music_changed", GlobalAudio, "set_music_volume")
	#GlobalSettings.load_settings()

# adapted from https://godotengine.org/qa/24773/how-to-load-and-change-scenes
func load_level(path: String) -> void:
	var next_level = load(path).instance()
	if level_object != null:
		GlobalViewport.viewport.call_deferred("remove_child", level_object)
		level_object.call_deferred("free")
	GlobalViewport.viewport.call_deferred("add_child", next_level)
	current_level_path = path

func reset_level():
	var new_level = load(current_level_path).instance()
	GlobalViewport.viewport.remove_child(level_object)
	level_object.call_deferred("free")
	GlobalViewport.viewport.add_child(new_level)
