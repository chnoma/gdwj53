extends Node


var viewport_container = null
var viewport = null
var mouse_pos := Vector2(0.0, 0.0)
var mouse_pos_ui := Vector2(0.0, 0.0)
var offset := Vector2(-64, 0.0)
var cursor_offset := Vector2(548,472)  # HACK: how to do this without fixed coords?

var fade_to_white: Fader
var fade_to_black: Fader

var cursor = null
var inventory = null

var mouse_in_inventory = false
