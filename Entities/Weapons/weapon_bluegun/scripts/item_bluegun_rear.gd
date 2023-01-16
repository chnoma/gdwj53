class_name Item_Bluegun_Rear
extends BaseItem

func _init():
	type = GlobalMaster.ItemTypes.REAR
	sprite = "res://Entities/Weapons/weapon_bluegun/sprites/inventory/bluegun_stock.png"
	adjective = "Blue"
	noun = "Gun"
	item_name = "Barrel"
	pointer = "res://Entities/Weapons/weapon_bluegun/bluegun_rear.tscn"
