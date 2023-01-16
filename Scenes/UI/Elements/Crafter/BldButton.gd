extends MouseElement

signal clicked()

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Area2D_area_entered(_area):
	GlobalViewport.cursor.focus_element(self)

func _on_Area2D_area_exited(_area):
	GlobalViewport.cursor.defocus_element(self)

func click_start():
	emit_signal("clicked")
