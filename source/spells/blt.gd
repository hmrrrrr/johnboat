extends TileModifierSpell

func set_status_tooltips():
	status_tooltips = [TileEffect.SUIT, TileStatus.CANDY]

func apply_to_tile(tile: Tile, _real_tile: Tile, is_preview: bool, _is_preview_update: bool) -> void :
	tile.set_face("♣%s♣"%tile.face)
	tile.add_status(TileStatus.CANDY)
	if not is_preview:
		tile.add_poofcloud(tile.get_color())


func is_tile_selectable(tile: Tile) -> bool:
	return (
		tile.is_face_modifiable() and 
		!tile.has_harmful_status() and 
		!tile.has_effect(TileEffect.SHIMMERING) and 
		len(tile.face) == 1 and 
		tile.has_face()
	)
