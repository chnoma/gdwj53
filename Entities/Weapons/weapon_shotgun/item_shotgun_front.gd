class_name Item_Shotgun_Front
extends BaseItem

func _init():
	type = GlobalMaster.ItemTypes.FRONT
	size = 1
	damage_coefficient = 0.07
	spread_coefficient = 1.7
	identifier = "ishf"
	prep_sprite()

func fire(_bullet, position, fire_direction, weapon, recursive):
	if !recursive:
		for i in 7:
			weapon.fire(position, fire_direction, true)
