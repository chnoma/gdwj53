class_name Item_Shotgun_Rear
extends BaseItem

func _init():
	type = GlobalMaster.ItemTypes.REAR
	size = 2
	spread_coefficient = 0.9
	damage_coefficient = 1.3
	identifier = "ishr"
	prep_sprite()
