class_name CraftingBox
extends InventorySlot

var crafting_sprites = {
	GlobalMaster.ItemTypes.TRASH: null,
	GlobalMaster.ItemTypes.FRONT: "res://Sprites/dev/ui/front_slot.png",
	GlobalMaster.ItemTypes.MID: "res://Sprites/dev/ui/mid_slot.png",
	GlobalMaster.ItemTypes.REAR: "res://Sprites/dev/ui/rear_slot.png"
}

export(GlobalMaster.ItemTypes) var type = GlobalMaster.ItemTypes.REAR

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
