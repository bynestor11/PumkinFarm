extends Node


onready var _dragdrop = $"../Drag&Drop"
onready var _entity : Node2D = get_parent()

func _unhandled_key_input(event):
	if _dragdrop.dragging:
		if event.pressed:
			if event.scancode == KEY_E:
				 _entity.rotation_degrees += 60
			if event.scancode == KEY_Q:
				 _entity.rotation_degrees -= 60
