class_name Env_BloodSurface
extends Sprite


var surface_image := Image.new()
var surface_texture := ImageTexture.new()
var blood_image := Image.new()
var blood_texture := ImageTexture.new()
var update = false
onready var rect = Rect2(global_position+GlobalEffects.BLOOD_SURFACE_SIZE/2, -GlobalEffects.BLOOD_SURFACE_SIZE)

func _ready():
	z_index = 1
	z_as_relative = false
# warning-ignore:narrowing_conversion
	surface_image.create(GlobalEffects.BLOOD_SURFACE_SIZE.x, abs(GlobalEffects.BLOOD_SURFACE_SIZE.y), false, Image.FORMAT_RGBAH)
	surface_image.fill(Color(0, 0, 0, 0))
	surface_texture.create_from_image(surface_image)
	
	blood_image.load("res://Sprites/particles/blood.png")
	blood_image.convert(Image.FORMAT_RGBAH)
	blood_texture.create_from_image(blood_image)
	
	texture = surface_texture

func contains_point(point: Vector2):
	var convert_pos = convert_to_local(point)
	return (convert_pos.x < GlobalEffects.BLOOD_SURFACE_SIZE.x &&\
			convert_pos.y < abs(GlobalEffects.BLOOD_SURFACE_SIZE.y) &&\
			convert_pos.x > 0 &&\
			convert_pos.y > 0)

func convert_to_local(point: Vector2):
	return point-global_position-GlobalEffects.BLOOD_SURFACE_SIZE/2+Vector2(128,0) #????

func draw_blood(draw_pos: Vector2):
	surface_image.lock()
	surface_image.blit_rect(blood_image, Rect2(Vector2(0,0), Vector2(1,1)), convert_to_local(draw_pos))
	surface_image.unlock()
	update = true

func _physics_process(_delta):
	if update:
		surface_texture.create_from_image(surface_image)
		update = false
