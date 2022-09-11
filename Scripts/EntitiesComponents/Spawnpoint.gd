extends Node2D

onready var item = load("res://Assets/Items/Pumkim.tscn")


func _ready():
	var _err = $"/root/root/Control".connect("grow_plant", self, "_on_spawn")


func _on_spawn():
	pass
	#self.instance(item)
