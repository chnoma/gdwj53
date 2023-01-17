class_name BaseEnemy
extends Node2D

export var health := 10

func _ready():
	pass # Replace with function body.

func damage(amount: int):
	health -= amount
	if health <= 0:
		die()

func die():
	queue_free()
