class_name BaseItem
extends Node2D

var type = GlobalMaster.ItemTypes.TRASH
var sprite = "res://Sprites/dev/item.png"
var item_name := "Invalid Item"
var pointer = null

var auto = false
var hitscan = true
var size = 1

var base_ammo := 30
var base_damage: float = 10
var base_durability := 10
var base_reload := 1.5
var base_rate_of_fire = 1.0
var base_spread = 0.1

var rate_of_fire_coefficient = 1.0
var spread_coefficient = 1.0
var ammo_coefficient = 1.0
var movement_coefficient = 1.0
var view_dist_coefficient = 1.0
var damage_coefficient = 1.0
var durability_coefficient = 1.0

var identifier

func prep_sprite():
	var part = GlobalMaster.ItemSuffix[type]
	var dir = get_script().get_path().get_base_dir()+"/sprites/inventory/"+part+".png"
	sprite = dir

func _ready():
	pass

func world_init():
	pass

func weapon_init(_weapon):
	pass

func fire(_bullet, _position, _fire_direction, _weapon, _recursive):
	pass

func bullet_process(_bullet):
	pass

func bullet_collide(_bullet, _other, _position, _weapon, _recursive):
	pass
