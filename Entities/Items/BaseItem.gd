class_name BaseItem
extends Node2D

var type = GlobalMaster.ItemTypes.TRASH
var sprite = "res://Sprites/dev/item.png"
var item_name := "Invalid Item"
var adjective = "invalid"
var noun = "item"
var pointer = null

var world_sprite = null
var attachment_offset = Vector2(0,-16)
var sprite_offset = null
var auto = false
var fire_delay_coefficient = 1.0
var spread_coefficient = 1.0
var hitscan = true

var attachment_point = null
var world_sprite_node = null

func prep_sprite():
	var part = GlobalMaster.ItemSuffix[type]
	var dir = get_script().get_path().get_base_dir()+"/sprites/inventory/"+part+".png"
	sprite = dir

func _ready():
	pass

func world_init():
	if world_sprite == null:
		var part = GlobalMaster.ItemSuffix[type]
		var dir = get_script().get_path().get_base_dir()+"/sprites/world/"+part+".png"
		print(dir)
		world_sprite = dir
	if sprite_offset == null:
		sprite_offset = Vector2(0, attachment_offset.y/2)
	attachment_point = Node2D.new()
	add_child(attachment_point)
	attachment_point.position = attachment_offset
	world_sprite_node = Sprite.new()
	add_child(world_sprite_node)
	world_sprite_node.position = sprite_offset
	world_sprite_node.texture = load(world_sprite)

func weapon_init(_weapon):
	pass

func fire(_bullet):
	pass

func bullet_process(_bullet):
	pass

func bullet_collide(_bullet, _other, _position):
	pass
