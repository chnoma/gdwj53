extends Node2D

func _ready():
	GlobalViewport.viewport_container = $ViewportContainer
	GlobalViewport.viewport = $ViewportContainer/Viewport
	GlobalViewport.fade_to_black = $fade_to_black
	GlobalViewport.fade_to_white = $fade_to_white
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	GlobalMaster.music_node = $music
