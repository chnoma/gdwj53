extends Node
# NOT A GREAT IDEA BUT NO TIME!!!!
var crafter
var shutter_active
var shutter_animation
var ui_ammo
var weapon_condition
var rear_state
var mid_state
var front_state
var durability_state
var ammo_state
var inventory_state

var base_weapon = preload("res://Entities/Weapons/BaseWeapon/BaseWeapon.tscn")

func recreate_weapon():
	var weapon = base_weapon.instance()
	weapon.rear_component = rear_state.new()
	weapon.mid_component = mid_state.new()
	weapon.front_component = front_state.new()
	return weapon
