class_name Item_Garand_Mid
extends BaseItem

func _init():
	type = GlobalMaster.ItemTypes.MID
	base_ammo = 5
	base_damage = 13
	base_durability = 20
	base_reload = 1.5
	base_rate_of_fire = 1.5
	hitscan = true
	identifier = "igm"
	prep_sprite()

func bullet_collide(bullet, other, position, weapon, _recursive):
	if other is BaseEnemy:
		other.damage(weapon.damage, position, weapon.last_direction)
	else:
		GlobalEffects.spark(7, position, 50)
