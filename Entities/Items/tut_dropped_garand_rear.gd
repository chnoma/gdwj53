extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.visible = false
	call_deferred("drop")

func drop():
	GlobalLoot.drop_loot(global_position, Item_Generic_Rear)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
