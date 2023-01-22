class_name Item_Garand_Front
extends BaseItem

func _init():
	type = GlobalMaster.ItemTypes.FRONT
	view_dist_coefficient = 1.2
	rate_of_fire_coefficient = 0.8
	spread_coefficient = 0.6
	movement_coefficient = 0.95
	identifier = "igf"
	prep_sprite()
