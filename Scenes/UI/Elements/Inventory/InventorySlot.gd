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
		$Line2D.visible = GlobalViewport.mouse_in_inventory
		$Line2D.set_point_position(0, $Line2D.to_local(GlobalViewport.mouse_pos_ui))

func _on_Area2D_area_entered(_area):
	GlobalViewport.cursor.focus_element(self)


func _on_Area2D_area_exited(_area):
	GlobalViewport.cursor.defocus_element(self)

func click_start():
	if is_empty():
		return
	item_prev_pos = $ItemSprite.global_position
	$Line2D.visible = true
	var endpoint
	if item.type == GlobalMaster.ItemTypes.FRONT:
		endpoint = GlobalHud.crafter.box_front.global_position
	elif item.type == GlobalMaster.ItemTypes.MID:
		endpoint = GlobalHud.crafter.box_mid.global_position
	elif item.type == GlobalMaster.ItemTypes.REAR:
		endpoint = GlobalHud.crafter.box_rear.global_position
	else:
		$Line2D.visible = false
	$Line2D.clear_points()
	$Line2D.add_point(Vector2(0,0))
	$Line2D.add_point($Line2D.to_local(endpoint))
	$ItemSprite.z_index = 901
	dragging = true

func click_end(receiver):
	if !dragging:
		return
	$ItemSprite.global_position = item_prev_pos
	$ItemSprite.z_index = 900
	$Line2D.visible = false
	dragging = false
	if !GlobalViewport.mouse_in_inventory:
		GlobalLoot.discard_item(item)
		clear_item()
		return
	if receiver == self:
		return
	if receiver as InventorySlot:
		if receiver.is_empty():
			receiver.set_item(item)
			clear_item()
		else:
			var hold = receiver.item
			receiver.set_item(item)
			set_item(hold)
