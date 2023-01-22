class_name BaseWeapon
extends Node2D

var bullet_prefab = preload("res://Entities/Weapons/BaseBullet/BaseBullet.tscn")

var rear_component
var mid_component
var front_component

var valid = false
var hitscan = true
var auto = false

var fire_delay = 0.2
var last_fire = 0

var base_ammo: int = 30
var current_ammo

var reload_time = 1.0

var max_durability: float
var current_durability: float

var damage
var spread: float

var size = 0

var last_direction

# Called when the node enters the scene tree for the first time.
func _ready():
	rear_component.world_init()
	mid_component.world_init()
	front_component.world_init()
	add_child(rear_component)
	add_child(mid_component)
	add_child(front_component)
	rear_component.weapon_init(self)
	mid_component.weapon_init(self)
	front_component.weapon_init(self)
	size = rear_component.size+mid_component.size+front_component.size
	auto = front_component.auto || mid_component.auto || rear_component.auto
	max_durability = mid_component.base_durability*front_component.durability_coefficient*rear_component.durability_coefficient
	base_ammo = min(max(mid_component.base_ammo*front_component.ammo_coefficient*rear_component.ammo_coefficient, 1), 99)
	fire_delay = 1/(mid_component.base_rate_of_fire*front_component.rate_of_fire_coefficient*rear_component.rate_of_fire_coefficient)
	damage = mid_component.base_damage*front_component.damage_coefficient*rear_component.damage_coefficient
	spread = mid_component.base_spread*front_component.spread_coefficient*rear_component.spread_coefficient
	current_durability = max_durability
	current_ammo = base_ammo
	refresh_hud()
	valid = true

func refresh_hud():
	GlobalHud.ui_ammo.set_available(base_ammo)
	GlobalHud.ui_ammo.set_current(current_ammo)
	GlobalHud.weapon_condition.frame = max(int((current_durability/max_durability)*10-1), 1)

func fire(position, fire_direction, recursive=false):
	if !recursive  && (!valid || OS.get_ticks_msec() - last_fire < fire_delay*1000 || current_ammo <= 0):
		return
	$sfx.play()
	GlobalAI.enemy_controller.alert_enemies(global_position, 256)
	last_fire = OS.get_ticks_msec()
	var spread_result = GlobalUtils.normalized_spread(fire_direction, spread)
	last_direction = spread_result
	var bullet = null
	if !hitscan:
		bullet = bullet_prefab.instance()
		bullet.velocity = (spread_result * 500)
		bullet.global_position = position
		rear_component.fire(bullet, self, recursive)
		mid_component.fire(bullet, self, recursive)
		front_component.fire(bullet, self, recursive)
		GlobalViewport.viewport.add_child(bullet)
	else:
		var space_state = get_world_2d().direct_space_state
		var endpoint = position+spread_result*500
		var result = space_state.intersect_ray(position, 
			endpoint, [],
			0x00000060, true, true)
		if result:
			rear_component.bullet_collide(null, result.collider, result.position, self, recursive)
			mid_component.bullet_collide(null, result.collider, result.position, self, recursive)
			front_component.bullet_collide(null, result.collider, result.position, self, recursive)
			endpoint = result.position
		else:
			pass
		GlobalEffects.draw_tracer(position,
								 endpoint,
								 Color(255, 255, 230),
								 0.02)
	
	if !recursive:
		rear_component.fire(bullet, position, fire_direction, self, recursive)
		mid_component.fire(bullet, position, fire_direction, self, recursive)
		front_component.fire(bullet, position, fire_direction, self, recursive)
		current_durability -= 1
		if current_durability <= 0:
			weapon_break()
			return
		GlobalHud.weapon_condition.frame = max(int((current_durability/max_durability)*10-1), 1)
		current_ammo -= 1
		if current_ammo <= 0:
			reload_start()
	refresh_hud()

func weapon_break():
	GlobalAudio.play_sound("res://Sounds/weapons/Gun break.wav", -6.0)
	GlobalHud.weapon_condition.frame = 0
	GlobalHud.ui_ammo.set_null()
	GlobalMaster.player.clear_weapon()
	queue_free()


func reload_start():
	$reload_start.play()
	var reload_timer = Timer.new()
	reload_timer.connect("timeout", self, "reload_finish")
	reload_timer.wait_time = reload_time
	reload_timer.one_shot = true
	add_child(reload_timer)
	reload_timer.start()


func reload_finish():
	$reload_end.play()
	current_ammo = base_ammo
	refresh_hud()
