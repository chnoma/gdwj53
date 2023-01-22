extends AudioStreamPlayer

var fading = false

func _process(delta):
	if !fading: return
	volume_db = max(volume_db-(80/3)*delta, 0)
	
