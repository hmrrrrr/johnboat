extends CanvasGroup
@onready var word_builder: WordBuilder = $".."
@onready var word_holder: WordHolder = $"../WordHolder"
const MUTAGEN_BUBBLE = preload("uid://b5083h6esx7ov")

func apply_color(c: Color, color_cycle: int) -> Color:
	match color_cycle:
		0:
			return c + Color(1,0,0)
	return c + Color(0,1,0)
	

func update_bubble(bubble, color_cycle: int, tile: Tile):
	bubble.bound_tile = tile
	var is_mutagen = tile.has_status("mutagen")
	var next_color_cycle := (color_cycle+1)%2
	
	var c = Color(0,0,0,1)
	c = apply_color(c, color_cycle)
	if is_mutagen:
		c = apply_color(c, next_color_cycle)
	
	bubble.modulate = c
	
			

func resize(tiles: Array[Tile]) -> void:
	tiles = tiles.duplicate()
	var i := 0
	
	var color_cycle: int = 0 # 0->1->2->0->...
	
	var last_was_mutagen: bool = false
	var l := 0
	var has_any_mutagen: bool = false
	for tile: Tile in tiles:
		if tile.is_space():
			tiles.erase(tile)
		if tile.has_status("mutagen"):
			has_any_mutagen = true
	if has_any_mutagen:
		l = len(tiles)
	for child in get_children():
		if i >= l:
			child.queue_free()
		else:
			var is_mutagen := tiles[i].has_status("mutagen")
			if (!is_mutagen) and (last_was_mutagen):
				color_cycle = (color_cycle+1)%2
			update_bubble(child,color_cycle,tiles[i])
			i += 1
			last_was_mutagen = is_mutagen
	while i < l:
		var inst = MUTAGEN_BUBBLE.instantiate()
		add_child(inst)
		var is_mutagen := tiles[i].has_status("mutagen")
		if (!is_mutagen) and (last_was_mutagen):
			color_cycle = (color_cycle+1)%2
		update_bubble(inst,color_cycle,tiles[i])
		last_was_mutagen = is_mutagen
		i += 1
func _on_word_holder_updated_tiles() -> void:
	resize(word_holder.tiles)
	
	
