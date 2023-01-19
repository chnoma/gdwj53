extends Node

enum ai_states { IDLE, AGGRO, WANDER, PATROL }
enum ai_types {MELEE, PISTOL, RIFLE}

var DEBUG_DRAW_TARGET = true
var DEBUG_DRAW_LOS = true

# gameplay variables
var BASE_SPEED = 280
#var TURN_SPEED = 720
#var MOVEMENT_TURN_COEFFICIENT = 0.5
var ALERT_RANGE = 200
var ENEMY_MIN_DISTANCE = 250
var MAX_AGGRESSORS = 2

var MELEE_RANGE = 32
var MELEE_COOLDOWN = 1

var AIM_ACQUISITION_TIME = 0.6
var BULLET_SPEED = 1200

var BURST_RANGE = 500
var BURST_COUNT = 3
var BURST_INTERVAL = 0.07
var BURST_COOLDOWN = 1

var NAV_TICKRATE = 12
var NAV_MIN_NODE_DISTANCE = 12

var enemy_controller = null


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
