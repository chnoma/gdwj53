extends Node

enum ItemTypes {TRASH, REAR, MID, FRONT}

var ItemSuffix = {
	ItemTypes.FRONT: "front",
	ItemTypes.REAR: "rear",
	ItemTypes.MID: "mid",
	ItemTypes.TRASH: "trash"
}

var player = null

onready var rng = RandomNumberGenerator.new()

func _ready():
# we do not care about these
# warning-ignore:return_value_discarded
	GlobalSettings.connect("volume_master_changed", GlobalAudio, "set_master_volume")
# warning-ignore:return_value_discarded
	GlobalSettings.connect("volume_sfx_changed", GlobalAudio, "set_sfx_volume")
# warning-ignore:return_value_discarded
	GlobalSettings.connect("volume_music_changed", GlobalAudio, "set_music_volume")
	GlobalSettings.load_settings()


