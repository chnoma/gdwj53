extends Node2D

export (String) var next_level = "res://Scenes/MainLevel.tscn"
export (bool) var preserve_inventory = false
export var music = "res://Music/theme.ogg"

func _ready():
	GlobalMaster.level_object = self
	call_deferred("setup")

func setup():
	GlobalEffects.blood_controller.clear()
	GlobalViewport.inventory.clear()
	GlobalHud.ui_ammo.set_null()
	GlobalHud.weapon_condition.frame = 0
	if GlobalMaster.is_reset || (preserve_inventory && GlobalHud.inventory_state):
		GlobalViewport.inventory.set_inventory_state(GlobalHud.inventory_state)
		if GlobalHud.ammo_state:
			GlobalMaster.player.equip_weapon(GlobalHud.recreate_weapon())
			GlobalMaster.player.weapon.current_ammo = GlobalHud.ammo_state
			GlobalMaster.player.weapon.current_durability = GlobalHud.durability_state
	GlobalMaster.freeze = false
	GlobalMaster.set_music(music)

func load_next():
	GlobalMaster.load_level(next_level)

func _on_exit_area_area_entered(area):
	GlobalMaster.freeze = true
	GlobalViewport.fade_to_black.fade(0.2)
	GlobalHud.inventory_state = GlobalViewport.inventory.get_inventory_state()
	if GlobalMaster.player.weapon:
		GlobalHud.front_state = GlobalLoot.bs_dict[GlobalMaster.player.weapon.front_component.identifier]
		GlobalHud.mid_state = GlobalLoot.bs_dict[GlobalMaster.player.weapon.mid_component.identifier]
		GlobalHud.rear_state = GlobalLoot.bs_dict[GlobalMaster.player.weapon.rear_component.identifier]
		GlobalHud.ammo_state = GlobalMaster.player.weapon.current_ammo
		GlobalHud.durability_state = GlobalMaster.player.weapon.current_durability
	var load_timer = Timer.new()
	load_timer.connect("timeout", self, "load_next")
	load_timer.wait_time = 0.2
	load_timer.one_shot = true
	add_child(load_timer)
	load_timer.start()
