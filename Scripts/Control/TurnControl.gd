extends Node

signal grow_plant
signal check_sell


func _ready():
	var err = get_node("TurnTimer").connect("timeout", self, "_on_turn")
	if err != OK:
		print_debug("Failure to connect timer")
	pass


func _on_turn() :
	emit_signal("grow_plant")
	emit_signal("check_sell")
	pass
