extends Node2D

var cursor_sprite = load("res://Sprites/dev/ui/cursor.png")
var crosshair_sprite = load("res://Sprites/dev/crosshair.png")

var focused_element = null
var clicked_element = null

func _ready():
	GlobalViewport.cursor = self

func _process(_delta):
	GlobalViewport.mouse_pos_ui = get_viewport().get_mouse_position()
	position = GlobalViewport.mouse_pos_ui - GlobalViewport.cursor_offset

func _input(event):
	if event is InputEventMouseButton && event.button_index == BUTTON_LEFT:
		if event.pressed:
			click_element_start()
		else:
			click_element_end()

func set_pointer(cursor: bool):
	if cursor:
		$Sprite.texture = cursor_sprite
	else:
		$Sprite.texture = crosshair_sprite

func _on_CursorArea_area_entered(_area):
	GlobalViewport.mouse_in_inventory = true
	set_pointer(true)

func _on_CursorArea_area_exited(_area):
	GlobalViewport.mouse_in_inventory = false
	set_pointer(false)

func focus_element(element):
	if focused_element != null:
		focused_element.defocus()
	focused_element = element
	focused_element.focus()

func defocus_element(element):
	element.defocus()
	if element == focused_element:
		focused_element = null

func click_element_start():
	if focused_element == null:
		return
	clicked_element = focused_element
	clicked_element.click_start()

func click_element_end():
	if clicked_element == null:
		return
	clicked_element.click_end(focused_element)
	clicked_element = null
