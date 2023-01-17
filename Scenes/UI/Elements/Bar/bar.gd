extends Node2D


export var border := true
export var border_color := Color(0,0,0)
export var border_thickness := 1
export var bg_color := Color(255, 0, 0)
export var fg_color := Color(0,255,0)
export var bar_size := Vector2(16, 1)

var value := 0.5

# Called when the node enters the scene tree for the first time.
func _ready():
	$border.visible = border
	if border:
		$border.rect_size = Vector2(bar_size.x+border_thickness*2, bar_size.y+border_thickness*2)
	$bar_bg.rect_size = bar_size
	$bar_fg.rect_position = Vector2(-bar_size.x/2, 0)
	$bar_fg.color = fg_color
	$bar_bg.color = bg_color
	$border.color = border_color
	set_value(value)

func set_value(v):
	$bar_fg.rect_size = Vector2(bar_size.x*v, bar_size.y)
	$bar_fg.rect_position = Vector2(-bar_size.x*value/2+border_thickness, -1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
