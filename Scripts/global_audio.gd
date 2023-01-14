extends Node

onready var master_bus = AudioServer.get_bus_index("Master")
onready var sfx_bus = AudioServer.get_bus_index("SFX")
onready var music_bus = AudioServer.get_bus_index("Music")

func _ready():
	pass # Replace with function body.

func convert_scale_to_db(input: float) -> float:
	return (1-input)*-50 # UPGRADE: different volume curve?

func set_master_volume(volume: float) -> void:
	AudioServer.set_bus_volume_db(master_bus, convert_scale_to_db(volume))

func set_sfx_volume(volume: float) -> void:
	AudioServer.set_bus_volume_db(sfx_bus, convert_scale_to_db(volume))

func set_music_volume(volume: float) -> void:
	AudioServer.set_bus_volume_db(music_bus, convert_scale_to_db(volume))
