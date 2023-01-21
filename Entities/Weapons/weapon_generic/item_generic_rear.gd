class_name Item_Generic_Rear
extends BaseItem

func _init():
	type = GlobalMaster.ItemTypes.REAR
	damage_coefficient = 1.2
	spread_coefficient = 0.5
	movement_coefficient = 0.95
	prep_sprite()
