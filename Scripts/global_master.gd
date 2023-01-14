extends Node

func _ready():
# we do not care about these
# warning-ignore:return_value_discarded
	GlobalSettings.connect("volume_master_changed", GlobalAudio, "set_master_volume")
# warning-ignore:return_value_discarded
	GlobalSettings.connect("volume_sfx_changed", GlobalAudio, "set_sfx_volume")
# warning-ignore:return_value_discarded
	GlobalSettings.connect("volume_music_changed", GlobalAudio, "set_music_volume")
	GlobalSettings.load_settings()
	
