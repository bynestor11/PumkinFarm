extends Node

const _hex = preload("res://Scripts/HexGrid/HexBase.gd")
onready var _entity = get_parent()

func _ready():
	var _err = $"/root/root/Control".connect("follow_rails", self, "_on_follow_rail")

func _on_follow_rail():
	var rail = _hex.find_at(_entity.position, $"../../../Backblocks")
	if rail != null:
		var railend = rail.get_node_or_null("RailEnd")
		if railend != null:
			if _hex.find_at(railend.global_position, $"../../../Items") == null:
				_entity.global_position = railend.global_position
