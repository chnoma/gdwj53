class_name DroppedItem
extends KinematicBody2D

var item_type = BaseItem
var item

var velocity = Vector2(0, 0)
onready var minimum_speed = 1
var friction_movement = 0.04

var rotation_speed = 0
var minimum_rotation_speed = 1
var friction_rotation = 0.02

var discarded = false

# Called when the node enters the scene tree for the first time.
func _ready():
	z_index = 2
	z_as_relative = false
	
	if item == null:
		item = item_type.new()
	
	$Sprite.texture = load(item.sprite)

func _process(delta):
	rotation_degrees += rotation_speed*delta
	move_and_slide(velocity)
	
	velocity -= velocity*friction_movement
	if abs(velocity.length_squared()) < minimum_speed:
		velocity = Vector2(0, 0)
		if discarded:
			queue_free()
	rotation_speed -= rotation_speed*friction_rotation
	if abs(rotation_speed) < minimum_rotation_speed:
		rotation_speed = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
