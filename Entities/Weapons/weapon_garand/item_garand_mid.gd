class_name Item_Garand_Mid
extends BaseItem

func _init():
	type = GlobalMaster.ItemTypes.MID
	adjective = "Old"
	noun = "Garand"
	item_name = "Barrel"
	auto = true
	prep_sprite()

func bullet_collide(_bullet, other, position):
	GlobalEffects.spark(7, position, 50)
	if other is BaseEnemy:
		other.damage(3)
