class_name BaseEnemy
extends KinematicBody2D

export var health := 10
export var speed := 1.0

onready var agent: NavigationAgent2D = $NavigationAgent2D

var state = GlobalAI.ai_states.IDLE

var player_in_range = false

func _ready():
	GlobalAI.enemy_controller.register_enemy(self)

func _process(_delta):
	if player_in_range && state != GlobalAI.ai_states.AGGRO:  # TODO: consider moving to slower loop
		var space_state = get_world_2d().direct_space_state
		var endpoint = GlobalMaster.player.position
		var worldresult = space_state.intersect_ray(position, 
			endpoint, [],
			0x00000020, true, true)
		if !worldresult:
			# player has been seen, alert
			GlobalAI.enemy_controller.alert_enemies(position, GlobalAI.ALERT_RANGE)
		if GlobalAI.DEBUG_DRAW_LOS:
			GlobalEffects.draw_tracer(position, GlobalMaster.player.position, Color(255,0,0), 0.01)

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
