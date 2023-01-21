class_name Item_Shotgun_Mid
extends BaseItem

func _init():
	type = GlobalMaster.ItemTypes.MID
	size = 1
	base_ammo = 8
	base_damage = 18
	base_reload = 3
	base_rate_of_fire = 1.5
	base_durability = 14
	base_spread = 0.12
	hitscan = true
	prep_sprite()

func bullet_collide(bullet, other, position, weapon, _recursive):
	if other is BaseEnemy:
		other.damage(weapon.damage, position, weapon.last_direction)
	else:
		GlobalEffects.spark(7, position, 50)
