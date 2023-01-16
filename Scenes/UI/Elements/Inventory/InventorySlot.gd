class_name InventorySlot
extends MouseElement


var item_prev_pos := Vector2(0.0, 0.0)
var dragging = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dragging:
		$ItemSprite.global_position = GlobalViewport.mouse_pos_ui

func _on_Area2D_area_entered(_area):
	GlobalViewport.cursor.focus_element(self)


func _on_Area2D_area_exited(area):
	GlobalViewport.cursor.defocus_element(self)

func click_start():
	item_prev_pos = $ItemSprite.global_position
	dragging = true

func click_end(receiver):
	$ItemSprite.global_position = item_prev_pos
	dragging = false
