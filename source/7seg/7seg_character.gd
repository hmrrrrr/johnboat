@tool
class_name SevenSegCharacter extends Resource

@export var segments: Array = [
	false,false,false,false,
	false,false,false,
] : set=_set_segments

@export var character: String

static func get_segment_bits(segments: Array):
	return (
		( 1 if segments[0] else 0) |
		( 2 if segments[1] else 0) |
		( 4 if segments[2] else 0) |
		( 8 if segments[3] else 0) |
		(16 if segments[4] else 0) |
		(32 if segments[5] else 0) |
		(64 if segments[6] else 0)
	)

func get_bits() -> int:
	#print_debug(character,get_segment_bits(segments))
	return get_segment_bits(segments)

func _set_segments(v):
	var arr = v.duplicate()
	arr.resize(7)
	segments = arr
