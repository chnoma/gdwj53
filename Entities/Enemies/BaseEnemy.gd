class_name BaseEnemy
extends KinematicBody2D

export var health := 10
export var speed := 1.0

onready var agent: NavigationAgent2D = $NavigationAgent2D
onready var fire_sfx = $fire_sfx

var state = GlobalAI.ai_states.IDLE
var type = GlobalAI.ai_types.MELEE

var player_in_range = false
var last_fire = 0

func _ready():
	GlobalAI.enemy_controller.register_enemy(self)

func _process(_delta):
	if GlobalMaster.player.alive && player_in_range && state != GlobalAI.ai_states.AGGRO:  # TODO: consider moving to slower loop
		if can_see_player():
			# player has been seen, alert
			GlobalAI.enemy_controller.alert_enemies(position, GlobalAI.ALERT_RANGE)
		if GlobalAI.DEBUG_DRAW_LOS:
			GlobalEffects.draw_tracer(position, GlobalMaster.player.position, Color(255,0,0), 0.01)

func melee():
	fire_sfx.play()
	last_fire = OS.get_ticks_msec()
	$melee_hurtbox/CollisionShape2D.disabled = false
	var resethurtbox = Timer.new()
	resethurtbox.connect("timeout", self, "disable_melee")
	resethurtbox.wait_time = 0.15
	resethurtbox.one_shot = true
	add_child(resethurtbox)
	resethurtbox.start()

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
