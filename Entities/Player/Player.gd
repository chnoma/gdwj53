extends KinematicBody2D

var velocity: Vector2 = Vector2(0,0)
var speed = 250
var weapon = null
# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalMaster.player = self

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
	
	if weapon != null:
		weapon.look_at(GlobalViewport.mouse_pos)
		weapon.rotation_degrees = weapon.rotation_degrees+90
		if Input.is_action_just_pressed("fire") and !GlobalViewport.mouse_in_inventory:
			weapon.fire(self)
	

func clear_weapon():
	if weapon != null:
		weapon.queue_free()
		weapon = null

func equip_weapon(weapon_in: BaseWeapon):
	clear_weapon()
	$Weapon_Attachment.add_child(weapon_in)
	weapon = weapon_in

func _on_PickupArea_area_entered(item):
	item = item.get_parent()
	if item is DroppedItem && !GlobalViewport.inventory.full():
		GlobalViewport.inventory.add_item(item.item_type)
		item.queue_free()
