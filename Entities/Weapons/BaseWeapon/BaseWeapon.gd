class_name BaseWeapon
extends Node2D

var bullet_prefab = preload("res://Entities/Weapons/BaseBullet/BaseBullet.tscn")

var rear_component_path = preload("res://Entities/Weapons/BaseComponent/Test/Rear.tscn")
var mid_component_path = preload("res://Entities/Weapons/BaseComponent/Test/Mid.tscn")
var front_component_path = preload("res://Entities/Weapons/BaseComponent/Test/Front.tscn")

var rear_component: BaseComponent = null
var mid_component: BaseComponent  = null
var front_component: BaseComponent  = null

var valid = false

# Called when the node enters the scene tree for the first time.
func _ready():
	rear_component = rear_component_path.instance()
	mid_component = mid_component_path.instance()
	front_component = front_component_path.instance()
	add_child(rear_component)
	rear_component.add_child(mid_component)
	mid_component.position = rear_component.attachment_point.position
	mid_component.add_child(front_component)
	front_component.position = mid_component.attachment_point.position
	rear_component.weapon_init(self)
	mid_component.weapon_init(self)
	front_component.weapon_init(self)
	valid = true
	valid = true

func fire(_player):
	var bullet = bullet_prefab.instance()
	rear_component.fire(bullet)
	mid_component.fire(bullet)
	front_component.fire(bullet)
	bullet.global_position = global_position
	bullet.velocity = (GlobalViewport.mouse_pos - front_component.attachment_point.global_position).normalized() * 400  # TODO: allows for diagonal out of barrel - do we care?
	bullet.global_position = front_component.attachment_point.global_position
	GlobalViewport.viewport.add_child(bullet)
