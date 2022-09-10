

const cellx = 52
const celly = 48
const offset = Vector2(32,32)



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


