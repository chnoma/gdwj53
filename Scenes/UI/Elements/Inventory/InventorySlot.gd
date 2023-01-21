class_name InventorySlot
extends MouseElement

signal item_set()
signal item_removed()

var item_prev_pos := Vector2(0.0, 0.0)
var dragging = false

var item = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func set_item(item_in: BaseItem):
	$set_sound.play()
	item = item_in
	$ItemSprite.visible = true
	$ItemSprite.texture = load(item.sprite)
	emit_signal("item_set")

func clear_item():
	if item == null:
		return
	$ItemSprite.visible = false
	item = null
	emit_signal("item_removed")

func is_empty() -> bool:
	return item == null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if dragging:
		$ItemSprite.global_position = GlobalViewport.mouse_pos_ui

func _on_Area2D_area_entered(_area):
	GlobalViewport.cursor.focus_element(self)


func _on_Area2D_area_exited(_area):
	GlobalViewport.cursor.defocus_element(self)

func click_start():
	if is_empty():
		return
	item_prev_pos = $ItemSprite.global_position
	dragging = true

func click_end(receiver):
	if !dragging:
		return
	$ItemSprite.global_position = item_prev_pos
	dragging = false
	if receiver == self:
		return
	if receiver as InventorySlot:
		if receiver.is_empty():
			receiver.set_item(item)
			clear_item()
