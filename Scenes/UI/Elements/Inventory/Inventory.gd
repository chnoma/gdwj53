extends Node2D


onready var slots = $Slots.get_children()

# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalViewport.inventory = self

func add_item(item_type):
	find_empty_slot().set_item(item_type.new())

func add_item_literal(item):
	find_empty_slot().set_item(item, true)

func find_empty_slot():
	for slot in slots:
		if slot.is_empty():
			return slot

func get_inventory_state():
	var items = []
	for slot in slots:
		if !slot.is_empty():
			items.append(GlobalLoot.bs_dict[slot.item.identifier])
	return items

func clear():
	for slot in slots:
		if !slot.is_empty():
			slot.clear_item()

func set_inventory_state(items):
	for item in items:
		add_item(item)

func full() -> bool:
	return find_empty_slot() == null
