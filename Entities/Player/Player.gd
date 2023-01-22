extends KinematicBody2D

var velocity: Vector2 = Vector2(0,0)
var speed = 250
var weapon = null
var alive = true
var look_direction = null

var last_melee = 0
var melee_range = 40

onready var selected_weapon_node = $weapons/weapon_none
# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalMaster.player = self

func _process(_delta):
	if GlobalMaster.freeze:
		return
	if !alive:
		return
		
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
	
	if Input.is_action_just_pressed("rmb"):
		GlobalMaster.set_bullet_time(true)
	elif Input.is_action_just_released("rmb"):
		GlobalMaster.set_bullet_time(false)
	
	# normalize so diagonal movement speed is same as any other
	desired_direction = desired_direction.normalized()
	
	look_direction = global_position.direction_to(GlobalViewport.mouse_pos)
	
	look_at(GlobalViewport.mouse_pos)
# warning-ignore:return_value_discarded
	move_and_slide(desired_direction*speed)
	
	GlobalPhysics.gravity = desired_direction*18
	
	if selected_weapon_node != $weapons/weapon_none:
		selected_weapon_node.look_at(GlobalViewport.mouse_pos)
		weapon.rotation_degrees = weapon.rotation_degrees+90

func _physics_process(_delta):
	if !alive || GlobalMaster.freeze:
		return
	
	if weapon != null:
		if Input.is_action_pressed("fire") && !GlobalViewport.mouse_in_inventory:
				var fire_direction = (GlobalViewport.mouse_pos - selected_weapon_node.fire_origin.global_position).normalized()
				if fire_direction.dot(selected_weapon_node.global_transform.basis_xform(Vector2.RIGHT)) < 0:
					return
				weapon.fire(selected_weapon_node.fire_origin.global_position, fire_direction)
	else:
		if Input.is_action_just_pressed("fire") && !GlobalViewport.mouse_in_inventory:
			melee()

func die():
	if GlobalMaster.prevent_reset:
		return
	$Sprite.visible = false
	$Splat.visible = true
	alive = false
	GlobalAI.enemy_controller.pacify_all()
	GlobalMaster.freeze = true
	GlobalViewport.fade_to_black.fade(1)
	var restart_timer = Timer.new()
	restart_timer.connect("timeout", GlobalMaster, "reset_level")
	restart_timer.wait_time = 1
	restart_timer.one_shot = true
	add_child(restart_timer)
	restart_timer.start()

func melee():
	$melee_sfx.play()
	var fire_direction = (GlobalViewport.mouse_pos - global_position).normalized()
	for enemy in GlobalAI.enemy_controller.get_enemies_in_radius(global_position, melee_range):
		if fire_direction.dot(global_position.direction_to(enemy.global_position)) < 0:
			continue
		enemy.damage(10, enemy.global_position, fire_direction)

func clear_weapon():
	selected_weapon_node.visible = false
	if weapon != null:
		selected_weapon_node = $weapons/weapon_none
		weapon.queue_free()
		weapon = null
	selected_weapon_node.visible = true

func equip_weapon(weapon_in: BaseWeapon):
	clear_weapon()
	weapon = weapon_in
	add_child(weapon)
	selected_weapon_node.visible = false
	if weapon_in.size <= 1:
		selected_weapon_node =  $weapons/weapon_light
	elif weapon_in.size <= 3:
		selected_weapon_node = $weapons/weapon_medium
	else:
		selected_weapon_node = $weapons/weapon_heavy
	selected_weapon_node.visible = true

func _on_PickupArea_area_entered(item):
	item = item.get_parent()
	if item is DroppedItem && !GlobalViewport.inventory.full() && !item.discarded:
		GlobalViewport.inventory.add_item(item.item_type)
		item.queue_free()


func _on_hitbox_area_entered(_area):
	die()
