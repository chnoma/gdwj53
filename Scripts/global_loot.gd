extends Node

var dropped_item = preload("res://Entities/Items/DroppedItem.tscn")

enum rarity { COMMON, RARE, ULTRARARE }

var loot_tables = {
	rarity.COMMON : [ Item_Garand_Front, Item_Garand_Mid, Item_Generic_Rear,
					  Item_Smg_Front, Item_Smg_Mid, Item_Smg_Rear,
					  Item_Shotgun_Front, Item_Shotgun_Mid, Item_Shotgun_Rear ]
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

func discard_item(item_discarded):
	var item = dropped_item.instance()
	item.global_position = GlobalMaster.player.global_position
	item.discarded = true
	item.item = item_discarded
	item.friction_movement /= 2
	item.rotation_speed = GlobalMaster.rng.randf_range(-180, 180)
	GlobalViewport.viewport.add_child(item)
	item.velocity = item.global_position.direction_to(GlobalViewport.mouse_pos)*800
