class_name BaseItem
extends Node

var type = GlobalMaster.ItemTypes.TRASH
var sprite = "res://Sprites/dev/item.png"
var item_name := "Invalid Item"
var adjective = "invalid"
var noun = "item"
var pointer = null

onready var texture = load(sprite)
