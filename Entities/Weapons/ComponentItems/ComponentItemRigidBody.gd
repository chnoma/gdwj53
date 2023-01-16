class_name ComponentRigidBody
extends RigidBody2D

func _integrate_forces(state):
	var dt = state.get_step()
	var gravity = GlobalPhysics.gravity
	var velocity = state.get_linear_velocity()

	state.set_linear_velocity((velocity + gravity * -1))

func _ready():
	set_use_custom_integrator(true)
