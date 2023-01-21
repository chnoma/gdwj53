extends Node2D

export (String) var next_level = "res://Scenes/MainLevel.tscn"

func _ready():
	GlobalMaster.level_object = self

func load_next():
	GlobalMaster.load_level(next_level)


func _on_Area2D_area_entered(area):
	load_next()
