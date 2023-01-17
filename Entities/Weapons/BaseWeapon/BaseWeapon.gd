class_name BaseWeapon
extends Node2D

var bullet_prefab = preload("res://Entities/Weapons/BaseBullet/BaseBullet.tscn")

var rear_component = null
var mid_component  = null
var front_component = null

var valid = false
var hitscan = true
var auto = false
var fire_delay = 0.1
var last_fire = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	rear_component.world_init()
	mid_component.world_init()
	front_component.world_init()
	add_child(rear_component)
	rear_component.position = Vector2(0,0) # HACK: needs to be reset
	rear_component.add_child(mid_component)
	mid_component.position = rear_component.attachment_point.position
	mid_component.add_child(front_component)
	front_component.position = mid_component.attachment_point.position
	rear_component.weapon_init(self)
	mid_component.weapon_init(self)
	front_component.weapon_init(self)
	valid = true

func fire(_player):
	if !valid || OS.get_ticks_msec() - last_fire < fire_delay*1000:
		return
	last_fire = OS.get_ticks_msec()
	var fire_direction = (GlobalViewport.mouse_pos - front_component.attachment_point.global_position).normalized()
	if fire_direction.dot(global_transform.basis_xform(Vector2.UP)) < 0:
		return  # a gun cannot shoot backwards
	if !hitscan:
		var bullet = bullet_prefab.instance()
		bullet.velocity = (fire_direction * 500)
		bullet.global_position = front_component.attachment_point.global_position
		rear_component.fire(bullet)
		mid_component.fire(bullet)
		front_component.fire(bullet)
		GlobalViewport.viewport.add_child(bullet)
	else:
		var space_state = get_world_2d().direct_space_state
		var result = space_state.intersect_ray(front_component.attachment_point.global_position, 
			front_component.attachment_point.global_position+fire_direction*500, [],
			0x7FFFFFFF, true, true)
		GlobalMaster.draw_tracer(front_component.attachment_point.global_position,
								 front_component.attachment_point.global_position+fire_direction*500,
								 Color(255, 255, 230),
								 0.02)
		if result:
			rear_component.bullet_collide(null, result.collider.get_parent(), result.position)
			mid_component.bullet_collide(null, result.collider.get_parent(), result.position)
			front_component.bullet_collide(null, result.collider.get_parent(), result.position)
		else:
			print("no hit")
