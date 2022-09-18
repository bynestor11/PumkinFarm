extends Node

signal grab
signal drop

func _ready():
	var dragdrop = get_node_or_null("../Drag&Drop")
	if dragdrop != null:
		dragdrop.connect("dragsignal", self, "_on_dragsignal")

func emit_grab():
	emit_signal("grab")

func emit_drop():
	emit_signal("drop")

func _on_dragsignal(var dragging : bool):
	if dragging:
		emit_signal("grab")
	else:
		emit_signal("drop")
