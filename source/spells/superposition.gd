extends TileModifierSpell


enum {
	SELECTING, 
	MERGING, 
}

var first_tile: Tile
var state: = SELECTING


func set_status_tooltips():
	status_tooltips = [TileStatus.ENHANCED, TileEffect.SHIMMERING]


func _use() -> void :
	state = SELECTING
	first_tile = await get_selection()
	if first_tile == null:
		_end_use()
		return

	first_tile.animation.play("pressed")

	state = MERGING

	var second_tile: Tile = await get_selection([first_tile])
	if second_tile == null:
		_end_use()
		return

	await apply_to_tile(second_tile, second_tile, false, false)

	_post_use()


func _end_use():
	state = SELECTING
	super._end_use()


func apply_to_tile(tile: Tile, real_tile: Tile, is_preview: bool, _is_preview_update: bool) -> void :
	var add_capital = real_tile.has_status(TileStatus.CAPITAL) or first_tile.has_status(TileStatus.CAPITAL)
	var add_period = real_tile.has_status(TileStatus.PERIOD) or first_tile.has_status(TileStatus.PERIOD)

	var change_tile: Tile = first_tile
	if is_preview:
		change_tile = tile
		change_tile.copy_tile(first_tile)

	change_tile.set_face(real_tile.faces+first_tile.faces)

	change_tile.add_status(TileStatus.ENHANCED)
	if add_capital:
		change_tile.add_status(TileStatus.CAPITAL)
	elif add_period:
		change_tile.add_status(TileStatus.PERIOD)

	if not is_preview:
		AudioManager.play_sound(Sounds.SPELLS.STAPLE)
		tile_board.swap_tiles(first_tile, real_tile, 0.08, 0.04)
		tile_board.remove_tile(real_tile, {settle = false, restock = false})
		real_tile.add_poofcloud(first_tile.get_color(), Globals.COLORS.BLEND_SMOKE)
		await Game.timeout(0.24)
		await tile_board.settle_board()
		await tile_board.fill_board()


func can_merge_tile(tile):
	return (
		tile.has_face()
		and not tile.is_indestructible()
		and not tile.has_any_effect(Globals.FULL_WILDCARD_EFFECTS + [TileStatus.BOMB, TileEffect.SLASHED, TileStatus.MYSTERY])
	)


func are_tiles_mergeable(tile_a: Tile, tile_b: Tile):
	if tile_a.face == tile_b.face:
		return false
	
	if not can_merge_tile(tile_a) or not can_merge_tile(tile_b):
		return false


	var a_special = tile_a.has_any_status([TileStatus.PERIOD, TileStatus.CAPITAL])
	var b_special = tile_b.has_any_status([TileStatus.PERIOD, TileStatus.CAPITAL])
	if a_special and b_special:
		return false
	
	
	if not (a_special or b_special):
		return true


	return true




func is_tile_selectable(tile: Tile) -> bool:
	if state == SELECTING:
		return true

	return are_tiles_mergeable(tile, first_tile)


func has_special_tile_tooltip():
	return state == MERGING
