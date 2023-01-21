class_name Item_Smg_Front
extends BaseItem

func _init():
	type = GlobalMaster.ItemTypes.FRONT
	size = 0
	ammo_coefficient = 1.5
	spread_coefficient = 1.4
	movement_coefficient = 1.15
	auto = true
	prep_sprite()
