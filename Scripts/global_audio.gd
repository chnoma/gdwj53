extends Node

var _audiostream = AudioStreamPlayer.new()

onready var master_bus = AudioServer.get_bus_index("Master")
onready var sfx_bus = AudioServer.get_bus_index("SFX")
onready var music_bus = AudioServer.get_bus_index("Music")

func _ready():
	add_child(_audiostream)

func convert_scale_to_db(input: float) -> float:
	return (1-input)*-50 # UPGRADE: different volume curve?

func set_master_volume(volume: float) -> void:
	AudioServer.set_bus_volume_db(master_bus, convert_scale_to_db(volume))

func set_sfx_volume(volume: float) -> void:
	AudioServer.set_bus_volume_db(sfx_bus, convert_scale_to_db(volume))

func set_music_volume(volume: float) -> void:
	AudioServer.set_bus_volume_db(music_bus, convert_scale_to_db(volume))

func play_sound(sound, volume_db=0.0, bus=sfx_bus):
	_audiostream.stream = load(sound)
	#_audiostream.bus = bus
	_audiostream.volume_db = volume_db
	_audiostream.play()
