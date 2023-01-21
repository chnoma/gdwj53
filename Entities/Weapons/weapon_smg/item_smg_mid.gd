class_name Item_Smg_Mid
extends BaseItem

func _init():
	type = GlobalMaster.ItemTypes.MID
	size = 1
	base_ammo = 15
	base_damage = 2
	base_reload = 0.75
	base_rate_of_fire = 15
	base_durability = 30
	base_spread = 0.2
	hitscan = true
	auto = true
	prep_sprite()

func bullet_collide(bullet, other, position, weapon, _recursive):
	if other is BaseEnemy:
		other.damage(weapon.damage, position, weapon.last_direction)
	else:
		GlobalEffects.spark(7, position, 50)
