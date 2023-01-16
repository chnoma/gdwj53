class_name BaseComponent
extends Node

onready var attachment_point = $attachment_point

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func weapon_init(_weapon):
	pass

func fire(_bullet):
	pass

func bullet_process(_bullet):
	pass

func bullet_collide(_bullet, _other):
	pass
