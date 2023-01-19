class_name Item_Garand_Mid
extends BaseItem

func _init():
	type = GlobalMaster.ItemTypes.MID
	adjective = "Old"
	noun = "Garand"
	item_name = "Barrel"
	auto = false
	prep_sprite()

func bullet_collide(_bullet, other, position):
	if other is BaseEnemy:
		other.damage(30)
	else:
		GlobalEffects.spark(7, position, 50)
