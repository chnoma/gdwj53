extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var card_change = Timer.new()
	card_change.connect("timeout", self, "stage1")
	card_change.wait_time = 1
	card_change.one_shot = true
	add_child(card_change)
	card_change.start()

func stage1():
	$Card1.fade(0.5)
	var card_change = Timer.new()
	card_change.connect("timeout", self, "stage2")
	card_change.wait_time = 3
	card_change.one_shot = true
	add_child(card_change)
	card_change.start()
	
func stage2():
	$Card1.fade(0.5, true)
	var card_change = Timer.new()
	card_change.connect("timeout", self, "stage3")
	card_change.wait_time = 1
	card_change.one_shot = true
	add_child(card_change)
	card_change.start()

func stage3():
	$Card2.fade(0.5)
	var card_change = Timer.new()
	card_change.connect("timeout", self, "stage4")
	card_change.wait_time = 3
	card_change.one_shot = true
	add_child(card_change)
	card_change.start()

func stage4():
	$Card2.fade(0.5, true)
	var card_change = Timer.new()
	card_change.connect("timeout", self, "stage5")
	card_change.wait_time = 1
	card_change.one_shot = true
	add_child(card_change)
	card_change.start()

func stage5():
	$Card3.fade(0.5)
	var card_change = Timer.new()
	card_change.connect("timeout", self, "stage6")
	card_change.wait_time = 3
	card_change.one_shot = true
	add_child(card_change)
	card_change.start()

func stage6():
	$Card4.fade(1)
	var card_change = Timer.new()
	card_change.connect("timeout", self, "stage7")
	card_change.wait_time = 2
	card_change.one_shot = true
	add_child(card_change)
	card_change.start()

func stage7():
	get_tree().change_scene("res://Scenes/UI/MainView/MainView.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
