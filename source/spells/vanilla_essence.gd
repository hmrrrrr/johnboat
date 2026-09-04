extends TileModifierSpell

func set_status_tooltips():
	status_tooltips = [TileStatus.POOP]

const FACES = {
	TileRegion.LEFT: "es",
	TileRegion.CENTER: "ss",
	TileRegion.RIGHT: "se",
}

func _spell_init():
	selectable_regions = [Selection.CENTER, Selection.LEFT_RIGHT]

func apply_to_tile(tile: Tile, _real_tile: Tile, is_preview: bool, _is_preview_update: bool) -> void :
	if selected_tile_region in FACES:
		tile.set_face(FACES[selected_tile_region])
		tile.add_status(TileStatus.POOP)
		if not is_preview:
			tile.add_poofcloud(tile.get_color())


func is_tile_selectable(tile: Tile) -> bool:
	return (
		tile.is_face_modifiable() and 
		!tile.has_harmful_status() and 
		!tile.has_effect(TileEffect.SHIMMERING)
	) and !(
		tile.face in FACES.values() and tile.has_status(TileStatus.POOP)
	)
