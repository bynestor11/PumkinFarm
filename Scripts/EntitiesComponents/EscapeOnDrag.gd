extends Node

onready var _entity = get_parent()

func _ready():
	var _err = $"../Drag&Drop".connect("dragsignal", self, "_on_drag_signal")

func _on_drag_signal(dragging : bool):
	if(dragging):
		var root = $"/root"
		_entity.get_parent().remove_child(_entity)
		root.get_node("root/Items").add_child(_entity)
