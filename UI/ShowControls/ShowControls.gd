extends Control

@onready var _is_visible:bool = false:
	set = show_controls
	

func _unhandled_input(event):
	if event.is_action_pressed("tab"):
		_is_visible = !_is_visible

func show_controls(value:bool) -> void: 
	_is_visible = value
	visible = _is_visible

