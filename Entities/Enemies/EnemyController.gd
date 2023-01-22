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
	if GlobalMaster.freeze:
		return
	var msec = OS.get_ticks_msec()
	for enemy in enemies:
		if !enemy:
			return
		if enemy.state != GlobalAI.ai_states.IDLE && !enemy.agent.is_target_reached():
			var speed = GlobalAI.BASE_SPEED
			if enemy.state != GlobalAI.ai_states.AGGRO:
				speed = GlobalAI.NON_AGGRO_SPEED
			var nextpos = enemy.agent.get_next_location()
			var direction = enemy.global_position.direction_to(nextpos)
			enemy.move_and_slide(direction*speed)
			enemy.look_at(nextpos)
		if enemy.state == GlobalAI.ai_states.AGGRO:
			if enemy.global_position.distance_to(GlobalMaster.player.global_position) < GlobalAI.MELEE_RANGE\
				&& msec - enemy.last_fire > GlobalAI.MELEE_COOLDOWN*1000:
					enemy.melee()

func register_enemy(enemy):
	if enemy is BaseEnemy:
		enemies.append(enemy)
	else:
		push_error("registered non-enemy to AI")

func deregister_enemy(enemy):
	enemies.find(enemy)
	enemies.remove(enemies.find(enemy))

func command_move(enemy, destination):
	enemy.agent.set_target_location(destination)

func pacify_all():
	for enemy in enemies:
		if enemy.state == GlobalAI.ai_states.AGGRO:
			enemy.state = GlobalAI.ai_states.IDLE

func update_nav():
	for enemy in enemies:
		if enemy.state == GlobalAI.ai_states.AGGRO:
			var nextpos = GlobalMaster.player.global_position
			command_move(enemy, nextpos)
			if GlobalAI.DEBUG_DRAW_TARGET:
				GlobalEffects.draw_tracer(enemy.global_position, nextpos, Color(255,0,0), timer_update_nav.wait_time)
		elif enemy.state == GlobalAI.ai_states.PATROL:
			if enemy.patrol_node == null:
				enemy.state = GlobalAI.ai_states.IDLE
			elif enemy.agent.is_target_reached():
				command_move(enemy, enemy.patrol_node.global_position)
				enemy.patrol_node = enemy.patrol_node.next_node

func get_enemies_in_radius(position, radius):
	var return_value = []
	for enemy in enemies:
		if enemy.global_position.distance_to(position) < radius && enemy.alive:
			return_value.append(enemy)
	return return_value


func alert_enemies(position, radius):
	for enemy in get_enemies_in_radius(position, radius):
		if enemy.state != GlobalAI.ai_states.AGGRO:
			enemy.state = GlobalAI.ai_states.AGGRO
