extends TileModifierSpell

const ZIPTIE_LINKED_TURNS := 5

func set_status_tooltips():
	status_tooltips = [
		{status=TileStatus.LINKED,linked_color="ziptie",linked_turns=ZIPTIE_LINKED_TURNS},
		TileEffect.WILDCARD,
	]


func apply_to_tile(tile: Tile, _real_tile: Tile, is_preview: bool, _is_preview_update: bool) -> void :
	tile.add_status(TileStatus.LINKED,"ziptie",ZIPTIE_LINKED_TURNS)
	tile.set_face("*")
	if not is_preview:
		tile.add_poofcloud(tile.get_color())


func _use():
	var first_tile = await get_selection()
	if first_tile == null:
		_end_use()
		return

	first_tile.animation.play("pressed")

	var second_tile = await get_selection([first_tile])
	if second_tile == null:
		_end_use()
		return

	AudioManager.play_sound(Sounds.UMAMI_SOUNDS.CHAIN)
	apply_to_tile(first_tile, first_tile, false, false)
	#first_tile.add_status(TileStatus.CAPITAL)
	apply_to_tile(second_tile, second_tile, false, false)
	#second_tile.add_status(TileStatus.PERIOD)

	_post_use()


func is_tile_selectable(tile: Tile) -> bool:
	return (
		not tile.has_harmful_status()
		and not tile.has_effect(TileEffect.SHIMMERING)
		and not tile.has_status(TileStatus.MYSTERY)
		and not (tile.has_effect(TileEffect.WILDCARD) and tile.is_single_letter(true, false))
		and tile.is_face_modifiable()
		and !tile.has_effect(TileStatus.LINKED)
		and tile.type == TileType.DEFENSE
	)
