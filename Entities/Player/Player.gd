extends KinematicBody2D


var velocity: Vector2 = Vector2(0,0)
var speed = 250

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(_delta):
	velocity = Vector2(0,0)
	
	var desired_direction = Vector2(0,0)
	
	if Input.is_action_pressed("move_up"):
		desired_direction.y -= 1
	if Input.is_action_pressed("move_down"):
		desired_direction.y += 1
	if Input.is_action_pressed("move_left"):
		desired_direction.x -= 1
	if Input.is_action_pressed("move_right"):
		desired_direction.x += 1
	
	# normalize so diagonal movement speed is same as any other
	desired_direction = desired_direction.normalized()
	
	look_at(GlobalViewport.mouse_pos)
# warning-ignore:return_value_discarded
	move_and_slide(desired_direction*speed)
	
	GlobalPhysics.gravity = desired_direction*18
	
	if Input.is_action_just_pressed("fire") and !GlobalViewport.mouse_in_inventory:
		$Weapon_Attachment/Weapon.fire(self)
	
