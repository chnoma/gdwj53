extends Node2D

var tscn = preload("res://Entities/Enemies/boss_bullet.tscn")


func _ready():
	pass # Replace with function body.


func spawn():
	for node in get_children():
		var bullet = tscn.instance()
		bullet.velocity = node.global_position.direction_to(node.target.global_position)*250
		GlobalMaster.level_object.add_child(bullet)
		bullet.global_position = node.global_position
