extends Node

var dropped_item = preload("res://Entities/Items/DroppedItem.tscn")

enum rarity { COMMON, RARE, ULTRARARE }

var loot_tables = {
	rarity.COMMON : [ Item_Garand_Front, Item_Garand_Mid, Item_Generic_Rear ]
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func drop_loot(position: Vector2):
	var item = dropped_item.instance()
	item.global_position = position
	item.item_type = loot_tables[rarity.COMMON][GlobalMaster.rng.randi()%loot_tables[rarity.COMMON].size()]
	item.velocity = Vector2(GlobalMaster.rng.randf_range(-160, 160), GlobalMaster.rng.randf_range(-160, 160))
	item.rotation_speed = GlobalMaster.rng.randf_range(-180, 180)
	GlobalViewport.viewport.add_child(item)
