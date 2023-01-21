class_name Item_Garand_Mid
extends BaseItem

func _init():
	type = GlobalMaster.ItemTypes.MID
	adjective = "Old"
	noun = "Garand"
	item_name = "Barrel"
	auto = false
	prep_sprite()

func bullet_collide(bullet, other, position):
	if other is BaseEnemy:
		other.damage(30)
		GlobalEffects.blood_controller.spray_blood(position, GlobalMaster.player.look_direction)
	else:
		GlobalEffects.spark(7, position, 50)
