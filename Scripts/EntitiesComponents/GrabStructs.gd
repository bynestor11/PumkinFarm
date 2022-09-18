extends Node

const _hex = preload("res://Scripts/HexGrid/HexBase.gd")

func _ready():
	var _err = $"../GrabDropSignal".connect("drop", self, "_on_drop")


func _on_drop():
	_grab_structs_around_pos(get_parent().global_position)

func _grab_structs_around_pos(pos):
	var adjacent : Array = _hex.get_adjacent(pos, $"../..")
	for item in adjacent:
		if item.is_in_group("Structure"):
			var aux_pos = item.global_position
			item.get_parent().remove_child(item)
			get_parent().add_child(item)
			item.global_position = aux_pos
		else:
			adjacent.erase(item)
	
	for structure in adjacent:
		_grab_structs_around_pos(structure.global_position)
