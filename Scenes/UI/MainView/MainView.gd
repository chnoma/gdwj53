extends Node2D

func _ready():
	GlobalViewport.viewport_container = $ViewportContainer
	GlobalViewport.viewport = $ViewportContainer/Viewport
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
