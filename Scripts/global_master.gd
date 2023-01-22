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
var music_node: AudioStreamPlayer
var is_reset = false
var freeze = false
var first_level = "res://Scenes/Tutorial.tscn"
var last_music_track = ""
var prevent_reset = false

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
	if prevent_reset:
		return
	is_reset = true
	var new_level = load(current_level_path).instance()
	GlobalViewport.viewport.remove_child(level_object)
	level_object.call_deferred("free")
	GlobalViewport.viewport.add_child(new_level)
	is_reset = false

func set_music(track_path):
	if track_path != last_music_track:
		music_node.stop()
		music_node.stream = load(track_path)
		music_node.play()
	last_music_track = track_path
		
