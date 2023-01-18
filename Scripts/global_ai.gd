extends Node

enum ai_states { IDLE, AGGRO }
enum ai_types {MELEE, PISTOL, RIFLE}

var DEBUG_DRAW_TARGET = false
var DEBUG_DRAW_LOS = false

# gameplay variables
var BASE_SPEED = 280
var ALERT_RANGE = 200
var ENEMY_MIN_DISTANCE = 250
var MAX_AGGRESSORS = 2

var MELEE_RANGE = 32
var MELEE_COOLDOWN = 1

var NAV_TICKRATE = 12
var NAV_MIN_NODE_DISTANCE = 12

var enemy_controller = null


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
