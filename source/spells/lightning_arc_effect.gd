extends Line2D
class_name LightningArc
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var tile_list_to_init: Array[Tile]

func kill() -> void:
	queue_free()
	

func _ready() -> void:
	points = []
	animation_player.play("arc")
	create_line_from_tiles(tile_list_to_init)

func create_line_from_tiles(tiles: Array[Tile]):
	var second_tile := tiles[1]
	var second_to_last_tile := tiles[len(tiles)-2]
	var last_tile := tiles[len(tiles)-1]
	
	
	var get_tile_position = func(tile: Tile): return to_local(tile.global_position)
	
	var arr: PackedVector2Array
	
	var curving_position_a: Vector2 = lerp(
		get_tile_position.call(tiles[0]), get_tile_position.call(second_tile),.25
	)
	var curving_position_b: Vector2 = lerp(
		get_tile_position.call(last_tile), get_tile_position.call(second_to_last_tile),.25
	)
	arr.append(curving_position_a)
	for tile in tiles:
		arr.append(get_tile_position.call(tile))
	
	arr.append(curving_position_b)
	
	points = arr
