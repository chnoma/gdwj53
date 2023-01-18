class_name Item_Garand_Front
extends BaseItem

func _init():
	type = GlobalMaster.ItemTypes.FRONT
	adjective = "Old"
	noun = "Garand"
	item_name = "Barrel"
	attachment_offset = Vector2(0,-3)
	prep_sprite()
