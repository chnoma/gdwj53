extends Node2D

export (NodePath) onready var box_rear = get_node(box_rear)
export (NodePath) onready var box_mid = get_node(box_mid)
export (NodePath) onready var box_front = get_node(box_front)

var base_weapon = preload("res://Entities/Weapons/BaseWeapon/BaseWeapon.tscn")
var animation_shutter_close = preload("res://Sprites/UI/shutter_animation_close.tres")
var animation_shutter_open = preload("res://Sprites/UI/shutter_animation_open.tres")
var animation_shutter_open_fail = preload("res://Sprites/UI/shutter_animation_open_fail.tres")

var interactable = true

func _ready():
# warning-ignore:return_value_discarded
	$BldButton.connect("clicked", self, "build_start")
	GlobalHud.crafter = self
	box_rear.connect("item_set", self, "check_boxes")
	box_mid.connect("item_set", self, "check_boxes")
	box_front.connect("item_set", self, "check_boxes")
	box_rear.connect("item_removed", self, "check_boxes")
	box_mid.connect("item_removed", self, "check_boxes")
	box_front.connect("item_removed", self, "check_boxes")


func build_start():
	if !boxes_full() || !interactable:
		return
	else:
		interactable = false
		GlobalHud.shutter_animation.frames = animation_shutter_close
		GlobalHud.shutter_animation.frame = 0
		GlobalHud.shutter_animation.visible = true
		var buildtimer = Timer.new()
		buildtimer.connect("timeout", self, "build_finish")
		buildtimer.wait_time = 3
		buildtimer.one_shot = true
		add_child(buildtimer)
		buildtimer.start()
		$craft_sfx.play()
		$sfx_loop.play()

func build_finish():
	$sfx_loop.stop()
	interactable = true
	process_weapon()
	GlobalHud.shutter_animation.frame = 0
	var animation_hide = Timer.new()
	animation_hide.connect("timeout", self, "hide_animation")
	animation_hide.wait_time = 0.8
	animation_hide.one_shot = true
	add_child(animation_hide)
	animation_hide.start()

func hide_animation():
	GlobalHud.shutter_animation.visible = false

func process_weapon():
	if box_rear.item.type != GlobalMaster.ItemTypes.REAR ||\
		   box_mid.item.type != GlobalMaster.ItemTypes.MID ||\
		   box_front.item.type != GlobalMaster.ItemTypes.FRONT:
			$sfx_invalid.play()
			GlobalHud.shutter_animation.frames = animation_shutter_open_fail
	else:
		$ding.play()
		GlobalHud.shutter_animation.frames = animation_shutter_open
		var weapon = base_weapon.instance()
		weapon.rear_component = box_rear.item
		weapon.mid_component = box_mid.item
		weapon.front_component = box_front.item
		box_rear.clear_item()
		box_mid.clear_item()
		box_front.clear_item()
		GlobalMaster.player.equip_weapon(weapon)

func check_boxes():
	GlobalHud.shutter_active.frame = 1
	GlobalHud.shutter_active.visible = boxes_full()

func boxes_full():
	return !(box_rear.item == null || box_mid.item == null || box_front.item == null)
