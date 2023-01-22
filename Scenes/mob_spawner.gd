extends Node2D

var goon = preload("res://Entities/Enemies/goon.tscn")

var spawning = false

# Called when the node enters the scene tree for the first time.
func _ready():
	var spawn_timer = Timer.new()
	spawn_timer.connect("timeout", self, "spawn")
	spawn_timer.wait_time = 10
	spawn_timer.one_shot = false
	add_child(spawn_timer)
	spawn_timer.start()

func spawn():
	if spawning:
		var newgoon = goon.instance()
		newgoon.state = GlobalAI.ai_states.AGGRO
		add_child(newgoon)
		newgoon.position = Vector2(0,0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
