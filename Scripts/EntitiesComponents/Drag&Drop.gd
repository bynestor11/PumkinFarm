extends CollisionObject2D

var dragging = false

signal dragsignal;

onready var _tree = get_tree()
onready var _entity = get_node("..")
onready var _hex = load("res://Scripts/HexGrid/HexBase.gd")
onready var _stored_z_index = _entity.z_index

var _stored_position : Vector2


func _process(_delta):
	if dragging:
		var mousepos = get_viewport().get_mouse_position()
		_entity.position = Vector2(mousepos.x, mousepos.y)


func _set_drag_pc(var new_drag : bool):
	dragging = new_drag
	# drag code
	if dragging == true:
		emit_signal("dragsignal", dragging)
		_stored_position = _entity.global_position
		# keep item at top of z index
		_entity.z_index = 500
	# end of drag code
	# drop code
	if dragging == false:
		if _hex.find_at(_hex.round_to_hex(_entity.global_position), $"../..", _entity) == null :
			_entity.global_position = _hex.round_to_hex(_entity.global_position)
		else:
			_entity.global_position = _stored_position
		_entity.z_index = _stored_z_index
		emit_signal("dragsignal", dragging)
	# end of drop code


#func _input_event(_viewport, event, _shape_idx):
#	if event is InputEventMouseButton:
#		if event.button_index == BUTTON_LEFT and event.pressed:
#			_set_drag_pc(true)
#		elif event.button_index == BUTTON_LEFT and !event.pressed:
#			_set_drag_pc(false)
#	elif event is InputEventScreenTouch:
#		if event.pressed and event.get_index() == 0:
#			_entity.global_position = event.get_global_position()

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
