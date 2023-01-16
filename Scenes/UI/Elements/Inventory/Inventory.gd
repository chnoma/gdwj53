extends Node2D


onready var slots = $Slots.get_children()

# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalViewport.inventory = self
	add_item(Item_Bluegun_Rear)
	add_item(Item_Bluegun_Mid)
	add_item(Item_Bluegun_Front)
	add_item(BaseRear)
	add_item(BaseMid)
	add_item(BaseFront)
	add_item(Item_Bluegun_Rear)
	add_item(Item_Bluegun_Mid)
	add_item(Item_Bluegun_Front)
	add_item(BaseRear)
	add_item(BaseMid)
	add_item(BaseFront)

func add_item(item_type):
	find_empty_slot().set_item(item_type.new())

func find_empty_slot():
	for slot in slots:
		if slot.is_empty():
			return slot

func full() -> bool:
	return find_empty_slot() == null
