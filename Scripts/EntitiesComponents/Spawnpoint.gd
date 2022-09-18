extends Node2D

export var spawn_prob : float = 1
export onready var item = load("res://Assets/Items/Pumkim.tscn")

onready var _item_group = $"../../../Items"
onready var _dragdrop = get_node_or_null("../Drag&Drop")
onready var _rand = RandomNumberGenerator.new()
onready var _hex = load("res://Scripts/HexGrid/HexBase.gd")

func _ready():
	var _err = $"/root/root/Control".connect("grow_plant", self, "_on_spawn")
	_rand.randomize()


func _on_spawn():
	if(!_dragdrop.dragging):
		if(_rand.randf() < spawn_prob):
			if ( _hex.find_at(get_parent().position, _item_group) == null) :
				var spawn : Node2D = item.instance()
				_item_group.add_child(spawn)
				spawn.global_position = global_position
