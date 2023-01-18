class_name EnemyController
extends Node

var enemies = []
onready var timer_update_nav = Timer.new()

func _ready():
	GlobalAI.enemy_controller = self
	timer_update_nav.connect("timeout", self, "update_nav")
	timer_update_nav.wait_time = 1.0/GlobalAI.NAV_TICKRATE
	timer_update_nav.one_shot = false
	add_child(timer_update_nav)
	timer_update_nav.start()

func _process(_delta):
	for enemy in enemies:
		if enemy.state == GlobalAI.ai_states.AGGRO:
			var nextpos = enemy.agent.get_next_location()
			var direction = enemy.global_position.direction_to(nextpos)
			enemy.move_and_slide(direction*GlobalAI.BASE_SPEED)
			enemy.look_at(nextpos)

func register_enemy(enemy):
	if enemy is BaseEnemy:
		enemies.append(enemy)
	else:
		push_error("registered non-enemy to AI")

func deregister_enemy(enemy):
	enemies.remove(enemies.find(enemy))

func command_move(enemy, destination):
	enemy.agent.set_target_location(destination)

func update_nav():
	for enemy in enemies:
		if enemy.state == GlobalAI.ai_states.AGGRO:
			var nextpos = GlobalMaster.player.position
			command_move(enemy, nextpos)
			if GlobalAI.DEBUG_DRAW_TARGET:
				GlobalEffects.draw_tracer(enemy.position, nextpos, Color(255,0,0), timer_update_nav.wait_time)

func alert_enemies(position, radius):
	for enemy in enemies:
		if enemy.position.distance_to(position) < radius:
			enemy.state = GlobalAI.ai_states.AGGRO
