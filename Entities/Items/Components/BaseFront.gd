class_name BaseFront
extends BaseItem

func _init():
	type = GlobalMaster.ItemTypes.FRONT
	sprite = "res://Sprites/dev/weapon/component-front.png"
	adjective = "Basic"
	noun = "Gun"
	item_name = "Barrel"
	pointer = "res://Entities/Weapons/Components/BaseComponent/Test/Front.tscn"
