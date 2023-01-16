class_name MouseElement
extends Node2D

var focused: bool = false

func _ready():
	pass # Replace with function body.

func focus():
	focused = true

func defocus():
	if !focused:
		return
	focused = false

func click_start():
	pass

func click_end(_release_element):
	pass
