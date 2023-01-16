class_name Item_Bluegun_Front
extends BaseItem

func _init():
	type = GlobalMaster.ItemTypes.FRONT
	sprite = "res://Entities/Weapons/weapon_bluegun/sprites/inventory/bluegun_barrel.png"
	adjective = "Blue"
	noun = "Gun"
	item_name = "Barrel"
	pointer = "res://Entities/Weapons/weapon_bluegun/bluegun_front.tscn"
