class_name Env_BloodParticle
extends KinematicBody2D

var draw_surface = null
var velocity = Vector2(0, 0)
var start_life = 0
var lifetime = 0

func _ready():
	GlobalEffects.blood_controller.register_blood_particle(self)
