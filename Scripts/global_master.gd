extends Node

enum ItemTypes {TRASH, REAR, MID, FRONT}

var ItemSuffix = {
	ItemTypes.FRONT: "front",
	ItemTypes.REAR: "rear",
	ItemTypes.MID: "mid",
	ItemTypes.TRASH: "trash"
}

var player = null

func _ready():
# we do not care about these
# warning-ignore:return_value_discarded
	GlobalSettings.connect("volume_master_changed", GlobalAudio, "set_master_volume")
# warning-ignore:return_value_discarded
	GlobalSettings.connect("volume_sfx_changed", GlobalAudio, "set_sfx_volume")
# warning-ignore:return_value_discarded
	GlobalSettings.connect("volume_music_changed", GlobalAudio, "set_music_volume")
	GlobalSettings.load_settings()

func draw_tracer(origin, endpoint, color, lifetime):
	var tracer = Line2D.new()
	tracer.default_color = color
	tracer.add_point(origin)
	tracer.add_point(endpoint)
	tracer.width = 1
	GlobalViewport.viewport.add_child(tracer)
	var killtimer = Timer.new()
	killtimer.connect("timeout", self, "remove_object", [tracer])
	killtimer.wait_time = lifetime
	killtimer.one_shot = true
	GlobalViewport.viewport.add_child(killtimer)
	killtimer.start()

func remove_object(object):
	object.queue_free()
