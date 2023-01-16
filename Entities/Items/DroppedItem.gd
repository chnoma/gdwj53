class_name DroppedItem
extends Node2D

var item_type = BaseItem
onready var item = item_type.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	item = item_type.new()
	if item == null:
		push_error("created null item")
		print_stack()
		return
	else:
		$Sprite.texture = load(item.sprite)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
