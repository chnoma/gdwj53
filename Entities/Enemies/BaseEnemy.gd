class_name BaseEnemy
extends KinematicBody2D

signal dead()

var bullet_scene = preload("res://Entities/Weapons/BaseBullet/EnemyBullet.tscn")

export var health := 10
export var speed := 1.0

var agent

export(GlobalAI.ai_states) var state = GlobalAI.ai_states.IDLE
export(GlobalAI.ai_types) var type = GlobalAI.ai_types.MELEE

var player_in_range = false
var player_seen_time := 0.0
var last_fire = 0

export var start_node_patrol := @"";
var patrol_node = null

var alive = true

var blind = false

func _ready():
	if type != GlobalAI.ai_types.BOSS && type != GlobalAI.ai_types.SHIELD:
		agent = $NavigationAgent2D
		GlobalAI.enemy_controller.register_enemy(self)
		if start_node_patrol != @"":
			patrol_node = get_node(start_node_patrol) as Node2D
			GlobalAI.enemy_controller.command_move(self, patrol_node.position)
	$Sprite.material = $Sprite.material.duplicate()  # so each enemy flashes individually

func _physics_process(delta):
	if GlobalMaster.freeze || type == GlobalAI.ai_types.BOSS ||  type == GlobalAI.ai_types.SHIELD:
		return
	if GlobalMaster.player.alive && player_in_range && state != GlobalAI.ai_states.AGGRO && !blind:
		if can_see_player():
			# player has been seen, alert
			GlobalAI.enemy_controller.alert_enemies(global_position, GlobalAI.ALERT_RANGE)
		if GlobalAI.DEBUG_DRAW_LOS:
			GlobalEffects.draw_tracer(position, GlobalMaster.player.global_position, Color(255,0,0), 0.01)
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
	var endpoint = GlobalMaster.player.global_position
	var worldresult = space_state.intersect_ray(position, 
		endpoint, [],
		0x00000020, true, true)
	return !worldresult

func flash_white():
	set_whitening(1)
	var flash_timer = Timer.new()
	flash_timer.connect("timeout", self, "set_whitening", [0])
	flash_timer.wait_time = 0.05
	flash_timer.one_shot = true
	add_child(flash_timer)
	flash_timer.start()

func set_whitening(a):
	$Sprite.material.set_shader_param("whitening", a )

func die():
	if type == GlobalAI.ai_types.BOSS:
		return
	alive = false
	if type != GlobalAI.ai_types.SHIELD: 
		GlobalAI.enemy_controller.deregister_enemy(self)
	GlobalLoot.drop_loot(self.global_position)
	GlobalLoot.drop_loot(self.global_position)
	queue_free()
	emit_signal("dead")

func damage(amount, damage_position, direction):
	if !alive:
		return
	if type != GlobalAI.ai_types.BOSS && type != GlobalAI.ai_types.SHIELD:
		GlobalEffects.blood_controller.spray_blood(damage_position, direction)
	health -= amount
	if health <= 0:
		die()
	flash_white()

func _on_line_of_sight_area_entered(_area):
	player_in_range = true


func _on_line_of_sight_area_exited(_area):
	player_in_range = false
