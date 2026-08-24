@tool
extends "res://source/spell/charge_container.gd"

func update_max_charge(animate: = true) -> void :
	super(animate)
	var tiles := get_tiles()
	var new_tiles: = tiles.size()
	if new_tiles > 6:
		var tile_spacing = 1
		for i in new_tiles:
			var tile: = tiles[i]
			tile.position = Vector2( - tile_spacing * i,0)
