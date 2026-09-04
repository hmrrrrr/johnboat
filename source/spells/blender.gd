extends TileModifierSpell


var selected_tiles: Array[Tile]

func set_status_tooltips():
	status_tooltips = [TileEffect.SLASHED, TileStatus.CANDY]





func apply_to_tile(tile: Tile, real_tile: Tile, is_preview: bool, _is_preview_update: bool) -> void :
	
	var row = tile.get_coord().y

	var tiles = get_tiles({
		rows = [row], 
		sorted = true,
		exclude_tiles=[tile]
	})
	
	var inclusive_tiles = get_tiles({
		rows = [row], 
		sorted = true,
	})
	
	var add_capital = inclusive_tiles.any(func(t): t.has_status(TileStatus.CAPITAL))
	var add_period = inclusive_tiles.any(func(t): t.has_status(TileStatus.PERIOD))
	
	var faces = {}
	
	var valid_chars = Letters.ALPHABET + Letters.SUITS + Letters.NUMBERS
	for t: Tile in inclusive_tiles:
		if t.has_effect(TileEffect.SLASHED):
			for face in t.tile_face.slashed_faces:
				faces[face] = true
		elif (t.face in valid_chars):
			faces[t.face] = true
	
	for num in Letters.NUMPAD_CHARACTERS:
		var num_choices = Letters.NUMPAD_CHARACTERS[num]
		var valid := true
		for choice in num_choices:
			if choice not in faces.keys():
				valid = false
				break
		if !valid: valid = num in faces.keys()
		
		if valid:
			for choice in num_choices:
				faces.erase(choice)
			faces[num] = true
		
	tile.set_slashed(
		faces.keys()
	)

	tile.add_status(TileStatus.CANDY)
	if add_capital:
		tile.add_status(TileStatus.CAPITAL)
	elif add_period:
		tile.add_status(TileStatus.PERIOD)

	if not is_preview:
		AudioManager.play_sound(Sounds.PRODIGY.LONG,1.5)
		var last_tile: Tile
		for nth_tile in tiles:
			tile_board.remove_tile(nth_tile, {settle = false, restock = false})
		tile.add_poofcloud(tile.get_color(), Globals.COLORS.BLEND_SMOKE)
		await Game.timeout(0.24)
		await tile_board.settle_board()
		await tile_board.fill_board()
