

enum HexSides {
	RIGHT,
	BOTTOMRIGHT,
	BOTTOMLEFT,
	LEFT,
	TOPLEFT,
	TOPRIGHT
}

const cellx = 52
const celly = 48
const offset = Vector2(32,32)


static func adjacent_offset(hexside):
	match hexside:
		HexSides.RIGHT:
			return Vector2(cellx, 0)
		HexSides.LEFT:
			return Vector2(-cellx, 0)
		HexSides.BOTTOMRIGHT:
			#warning-ignore:INTEGER_DIVISION
			return Vector2(cellx/2, celly)
		HexSides.BOTTOMLEFT:
			#warning-ignore:INTEGER_DIVISION
			return Vector2(-cellx/2, celly)
		HexSides.TOPRIGHT:
			#warning-ignore:INTEGER_DIVISION
			return Vector2(cellx/2, -celly)
		HexSides.TOPLEFT:
			#warning-ignore:INTEGER_DIVISION
			return Vector2(-cellx/2, -celly)
		_:
			print_debug("BAD SIDE INPUT")

static func get_adjacent( pos : Vector2, search_node : Node):
	var adjacents = []
	for side in HexSides.values():
		var item = find_at( pos+adjacent_offset(side), search_node )
		if(item != null):
			adjacents.append(item)
	return adjacents

static func round_to_hex( pos : Vector2):
	#warning-ignore:INTEGER_DIVISION
	var _offrow_offset = int(celly / 2)
	var y_int : int = int(pos.y / celly)
	var x_int : int
	if y_int % 2 == 0:
		x_int = int(pos.x / cellx)
		#print("hex->", x_int, ",", y_int)
		return Vector2(x_int * cellx, y_int * celly) + offset
	else:
		x_int = int((pos.x - _offrow_offset) / cellx)
		#print("hex->", x_int, ",", y_int)
		return Vector2((x_int * cellx)+_offrow_offset, y_int * celly) + offset


static func find_at( pos : Vector2, search_node : Node, ignore : Node2D = null):
	for item  in search_node.get_children():
		if (ignore == null || item.name != ignore.name):
			if (round_to_hex(item.position) == round_to_hex(pos) ):
				return item
	return null
