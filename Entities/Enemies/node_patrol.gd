tool
extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var node_path := @""; onready var next_node := get_node(node_path) as Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
