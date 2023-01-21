extends Node


var blood_particles = []
var blood_surfaces = []

var minimum_speed = 1
var friction_movement = 0.04

func _ready():
	GlobalEffects.blood_controller = self

func register_blood_particle(particle):
	if particle is Env_BloodParticle:
		blood_particles.append(particle)
	else:
		push_error("registered non-particle to blood_particles")

func deregister_blood_particle(particle):
	blood_particles.remove(blood_particles.find(particle))

func register_blood_surface(surface):
	if surface is Env_BloodSurface:
		blood_surfaces.append(surface)
	else:
		push_error("registered non-surface to blood_surfaces")

func surface_at_point(point: Vector2):
	for surface in blood_surfaces:
		if surface.contains_point(point):
			return surface

func spray_blood(position, direction):
	for i in GlobalEffects.BLOOD_SPRAY_MAX_PARTICLES:
		var particle = Env_BloodParticle.new()
		particle.velocity = GlobalUtils.normalized_spread(direction, GlobalEffects.BLOOD_SPRAY_SPREAD)\
							*GlobalMaster.rng.randf_range(32, GlobalEffects.BLOOD_SPRAY_SPEED)
		particle.global_position = position + Vector2(GlobalMaster.rng.randf_range(0, 4),
													  GlobalMaster.rng.randf_range(0, 4))
		GlobalViewport.viewport.add_child(particle)
		

func _physics_process(_delta):
	for particle in blood_particles:
		particle.move_and_slide(particle.velocity)
		particle.velocity -= particle.velocity*friction_movement
		if abs(particle.velocity.length_squared()) < minimum_speed:
			deregister_blood_particle(particle)
			particle.queue_free()
		var surface = surface_at_point(particle.global_position)  # TODO: Group checks together - we don't need every particle to every surface
		if surface == null:
			surface = Env_BloodSurface.new()
			surface.global_position = Vector2(particle.global_position.x-fmod(particle.global_position.x, GlobalEffects.BLOOD_SURFACE_SIZE.x)+GlobalEffects.BLOOD_SURFACE_SIZE.x/2,
											  particle.global_position.y-fmod(particle.global_position.y, GlobalEffects.BLOOD_SURFACE_SIZE.y)+GlobalEffects.BLOOD_SURFACE_SIZE.y/2)
			GlobalViewport.viewport.add_child(surface)
			register_blood_surface(surface)
		surface.draw_blood(particle.global_position)
