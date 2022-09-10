extends CollisionObject2D

var dragging = false

signal dragsignal;

onready var _tree = get_tree()
onready var _entity = get_node("..")
onready var _hex = load("res://Scripts/HexGrid/HexBase.gd")


	
	
func _process(_delta):
	if dragging:
		var mousepos = get_viewport().get_mouse_position()
		_entity.position = Vector2(mousepos.x, mousepos.y)

		

func _set_drag_pc(var new_drag : bool):
	dragging = new_drag
	emit_signal("dragsignal")
	# drop code
	if dragging == false:
		_entity.position = _hex.round_to_hex(_entity.position)
	# end of drop code


#func _input_event(_viewport, event, _shape_idx):
#	if event is InputEventMouseButton:
#		if event.button_index == BUTTON_LEFT and event.pressed:
#			_set_drag_pc(true)
#		elif event.button_index == BUTTON_LEFT and !event.pressed:
#			_set_drag_pc(false)
#	elif event is InputEventScreenTouch:
#		if event.pressed and event.get_index() == 0:
#			_entity.position = event.get_position()

#Utiliza el orden del arbol para decidir que coge primero
func _input(event):
	if(dragging):
		_check_event(event)

func _unhandled_input(event):
	_check_event(event)

func _check_event(event):
	if event is InputEventMouseButton:
		var mouse_pos = get_local_mouse_position()
		var polygon = $CollisionPolygon2D.polygon
		if Geometry.is_point_in_polygon(mouse_pos,polygon):
			_tree.set_input_as_handled()
			if event.button_index == BUTTON_LEFT and event.pressed:
				_set_drag_pc(true)
			elif event.button_index == BUTTON_LEFT and !event.pressed:
				_set_drag_pc(false)
