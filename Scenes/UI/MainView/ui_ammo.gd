extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalHud.ui_ammo = self


func set_null():
	$current/tens.frame = 10
	$current/ones.frame = 10
	$available/tens.frame = 10
	$available/ones.frame = 10

func set_current_null():
	$current/tens.frame = 10
	$current/ones.frame = 10

func set_available(available: int):
	$available/tens.frame = (available-available%10)/10
	$available/ones.frame = available%10

func set_current(current: int):
	if current == 0:
		set_current_null()
	else:
		$current/tens.frame = (current-current%10)/10
		$current/ones.frame = current%10
