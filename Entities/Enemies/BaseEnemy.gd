class_name BaseEnemy
extends KinematicBody2D


var bullet_scene = preload("res://Entities/Weapons/BaseBullet/EnemyBullet.tscn")

export var health := 10
export var speed := 1.0

onready var agent: NavigationAgent2D = $NavigationAgent2D

var state = GlobalAI.ai_states.IDLE
export(GlobalAI.ai_types) var type = GlobalAI.ai_types.MELEE

var player_in_range = false
var player_seen_time := 0.0
var last_fire = 0

func _ready():
	GlobalAI.enemy_controller.register_enemy(self)

func _process(delta):
	if GlobalMaster.player.alive && player_in_range && state != GlobalAI.ai_states.AGGRO:  # TODO: consider moving to slower loop
		if can_see_player():
			# player has been seen, alert
			GlobalAI.enemy_controller.alert_enemies(position, GlobalAI.ALERT_RANGE)
		if GlobalAI.DEBUG_DRAW_LOS:
			GlobalEffects.draw_tracer(position, GlobalMaster.player.position, Color(255,0,0), 0.01)
	if state == GlobalAI.ai_states.AGGRO && type != GlobalAI.ai_types.MELEE:
		if can_see_player():
			player_seen_time += delta
		else:
			player_seen_time = 0
		if player_seen_time > GlobalAI.AIM_ACQUISITION_TIME && position.distance_to(GlobalMaster.player.position) < GlobalAI.BURST_RANGE\
				&& OS.get_ticks_msec() - last_fire > GlobalAI.BURST_COOLDOWN*1000:
			burst_fire()

func melee():
	$melee_sfx.play()
	last_fire = OS.get_ticks_msec()
	$melee_hurtbox/CollisionShape2D.disabled = false
	var resethurtbox = Timer.new()
	resethurtbox.connect("timeout", self, "disable_melee")
	resethurtbox.wait_time = 0.15
	resethurtbox.one_shot = true
	add_child(resethurtbox)
	resethurtbox.start()

func shoot_at_player():
	$fire_sfx.play()
	var bullet = bullet_scene.instance()
	bullet.velocity = position.direction_to(GlobalMaster.player.position+GlobalMaster.player.velocity*2)*GlobalAI.BULLET_SPEED
	bullet.global_position = global_position
	GlobalViewport.viewport.add_child(bullet)
	GlobalEffects.draw_tracer(position, bullet.position, Color(255,0,0), 4)

func burst_fire():
	shoot_at_player()
	for i in GlobalAI.BURST_COUNT-1:
		var burst_timer = Timer.new()
		burst_timer.connect("timeout", self, "shoot_at_player")
		burst_timer.wait_time = (i+1)*GlobalAI.BURST_INTERVAL
		burst_timer.one_shot = true
		add_child(burst_timer)
		burst_timer.start()
	last_fire = OS.get_ticks_msec()

func disable_melee():
	$melee_hurtbox/CollisionShape2D.disabled = true

func can_see_player():
	var space_state = get_world_2d().direct_space_state
	var endpoint = GlobalMaster.player.position
	var worldresult = space_state.intersect_ray(position, 
		endpoint, [],
		0x00000020, true, true)
	return !worldresult

func die():
	GlobalAI.enemy_controller.deregister_enemy(self)
	queue_free()

func damage(amount):
	health -= amount
	if health <= 0:
		die()

func _on_line_of_sight_area_entered(_area):
	player_in_range = true


func _on_line_of_sight_area_exited(_area):
	player_in_range = false
