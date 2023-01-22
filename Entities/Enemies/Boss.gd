extends BaseEnemy

var lasering = false

var lateral_bullets_fired = 0
var lateral_bullet_count = 16

var spin = true

func _ready():
	GlobalAI.BASE_SPEED = 196
	$mob_spawner_l.spawning = true
	$mob_spawner_r.spawning = true
	var timer_laser_on = Timer.new()
	timer_laser_on.connect("timeout", self, "warn_lasers")
	timer_laser_on.wait_time = 33
	timer_laser_on.one_shot = false
	add_child(timer_laser_on)
	timer_laser_on.start()
	var timer_lateral_bullets = Timer.new()
	timer_lateral_bullets.connect("timeout", self, "lateral_bullets")
	timer_lateral_bullets.wait_time = 12
	timer_lateral_bullets.one_shot = false
	add_child(timer_lateral_bullets)
	timer_lateral_bullets.start()

func _process(delta):
	if spin:
		$shields.rotation_degrees += 30*delta
		$lateral_bullets.rotation_degrees += 45*delta
		if lasering:
			$lasers.rotation_degrees -= 30*delta

func lateral_bullets():
	$sfx/bullet_fire.play()	
	$lateral_bullets.spawn()
	lateral_bullets_fired += 1
	if lateral_bullets_fired < lateral_bullet_count:
		var retrigger_bullets = Timer.new()
		retrigger_bullets.connect("timeout", self, "lateral_bullets")
		retrigger_bullets.wait_time = 0.25
		retrigger_bullets.one_shot = true
		add_child(retrigger_bullets)
		retrigger_bullets.start()
	else:
		lateral_bullets_fired = 0

func warn_lasers():
	$AnimationPlayer.play("warning")
	var timer_laser_on = Timer.new()
	timer_laser_on.connect("timeout", self, "enable_lasers")
	timer_laser_on.wait_time = 5
	timer_laser_on.one_shot = true
	add_child(timer_laser_on)
	timer_laser_on.start()

func die():
	alive = false
	spin = false
	disable_lasers()
	$mob_spawner_l.spawning = false
	$mob_spawner_r.spawning = false
	GlobalViewport.fade_to_white.fade(2, true)
	#GlobalMaster.music_node.fading = true
	var end_game = Timer.new()
	end_game.connect("timeout", self, "fade_to_white")
	end_game.wait_time = 5
	end_game.one_shot = true
	add_child(end_game)
	end_game.start()

func fade_to_white():
	GlobalViewport.fade_to_white.fade(3)
	var end_game = Timer.new()
	end_game.connect("timeout", self, "end_game")
	end_game.wait_time = 4
	end_game.one_shot = true
	add_child(end_game)
	end_game.start()

func end_game():
	GlobalViewport.fade_to_white.fade(3, true)
	get_tree().change_scene("res://Scenes/credits.tscn")

func enable_lasers():
	$sfx/laser_on.play()
	$sfx/laser_loop.play()
	$lasers.rotation_degrees = -45
	$lasers.visible = true
	$lasers/Area2D/CollisionShape2D.disabled = false
	$lasers/Area2D2/CollisionShape2D.disabled = false
	lasering = true
	var timer_laser_off = Timer.new()
	timer_laser_off.connect("timeout", self, "disable_lasers")
	timer_laser_off.wait_time = 10
	timer_laser_off.one_shot = true
	add_child(timer_laser_off)
	timer_laser_off.start()

func disable_lasers():
	$sfx/laser_off.play()
	$sfx/laser_loop.stop()
	$lasers.visible = false
	$lasers/Area2D/CollisionShape2D.disabled = true
	$lasers/Area2D2/CollisionShape2D.disabled = true
	lasering = false
