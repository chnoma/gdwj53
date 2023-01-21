extends Camera2D


export (NodePath) onready var player = get_node(player)

var game_size := Vector2(240, 135)
onready var window_scale : float = (OS.window_size / game_size).x
onready var actual_cam_pos := global_position
var base_mouse_pos = Vector2(708, 535)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	window_scale = (OS.window_size / game_size).x
	#var mouse_pos = GlobalViewport.viewport.get_mouse_position() / window_scale - (game_size/2) + player.global_position
	var mouse_pos_clamped = Vector2(min(GlobalViewport.mouse_pos_ui.x, 1500), GlobalViewport.mouse_pos_ui.y)
	var cam_pos = player.global_position + (mouse_pos_clamped-base_mouse_pos)/7
	
	actual_cam_pos = lerp(actual_cam_pos, cam_pos+player.velocity, delta*5)
	
	# Calculate the "subpixel" position of the new camera position
	var cam_subpixel_pos = actual_cam_pos.round() - actual_cam_pos
	
	# Update the Main ViewportContainer's shader uniform
	GlobalViewport.viewport_container.material.set_shader_param("cam_offset", cam_subpixel_pos )
	
	# Set the camera's position to the new position and round it.
	global_position = actual_cam_pos.round() - GlobalViewport.offset
	
	GlobalViewport.mouse_pos = actual_cam_pos + GlobalViewport.viewport.get_mouse_position()*2 / window_scale - game_size - GlobalViewport.offset  # HACK: Why two mousepos variables?
