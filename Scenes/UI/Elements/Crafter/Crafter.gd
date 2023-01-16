extends Node2D

export (NodePath) onready var box_rear = get_node(box_rear)
export (NodePath) onready var box_mid = get_node(box_mid)
export (NodePath) onready var box_front = get_node(box_front)

var base_weapon = preload("res://Entities/Weapons/BaseWeapon/BaseWeapon.tscn")

func _ready():
# warning-ignore:return_value_discarded
	$BldButton.connect("clicked", self, "build")


func build():
	if box_rear.item == null || box_mid.item == null || box_front.item == null:
		print("not full - no go")
		return
	else:
		# we have items in all slots
		if box_rear.item.type != GlobalMaster.ItemTypes.REAR ||\
		   box_mid.item.type != GlobalMaster.ItemTypes.MID ||\
		   box_front.item.type != GlobalMaster.ItemTypes.FRONT:
			print("invalid combo")
			box_rear.clear_item()
			box_mid.clear_item()
			box_front.clear_item()
		else:
			var weapon = base_weapon.instance()
			weapon.rear_component_path = box_rear.item.pointer
			weapon.mid_component_path = box_mid.item.pointer
			weapon.front_component_path = box_front.item.pointer
			box_rear.clear_item()
			box_mid.clear_item()
			box_front.clear_item()
			GlobalMaster.player.equip_weapon(weapon)
