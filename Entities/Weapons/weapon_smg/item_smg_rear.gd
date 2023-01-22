class_name Item_Smg_Rear
extends BaseItem

func _init():
	type = GlobalMaster.ItemTypes.REAR
	size = 0
	spread_coefficient = 1.3
	rate_of_fire_coefficient = 1.25
	damage_coefficient = 0.9
	movement_coefficient = 1.15
	identifier = "isr"
	prep_sprite()
