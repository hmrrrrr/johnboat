extends TileModifierSpell

func set_status_tooltips():
	status_tooltips = [TileStatus.MYSTERY, TileStatus.FROZEN]

func get_tooltip_context():
	return {}


func is_ngram_valid(ngram: String, letter_pool: Array[String]) -> bool:
	var remaining_letter_pool = letter_pool.duplicate()
	for i in len(ngram):
		if ngram[i] in remaining_letter_pool:
			remaining_letter_pool.erase(ngram[i])
		else:
			return false
	return true


func apply_to_tile(tile: Tile, _real_tile, is_preview, _is_preview_update):
	if is_preview:
		tile.add_status(TileStatus.MYSTERY)
	
	if not is_preview:
		var tiles_to_remove = tile_board.get_tiles({
			sorted=true, 
			custom_tile_check = func(tile: Tile, _parameters: Dictionary):
				if (len(tile.face) == 1):
					return Letters.get_face_value(tile.face) == 1 and tile.has_face()
				return false
		})
		var letter_pool: Array[String] = []
		for destroyed_tile in tiles_to_remove:
			letter_pool.append(destroyed_tile.face)
			
		var ngram_pool: Dictionary[String, float] = {}
		
		for trigram in Letters.TRIGRAMS.keys():
			if is_ngram_valid(trigram,letter_pool):
				ngram_pool[trigram] = Letters.TRIGRAMS[trigram]
		
		if len(ngram_pool.keys()) < 3:
			ngram_pool = {}
			for bigram in Letters.BIGRAMS.keys():
				if is_ngram_valid(bigram,letter_pool):
					ngram_pool[bigram] = Letters.BIGRAMS[bigram]
		
		var ngram_choice = ""
		
		if len(ngram_pool.keys()) < 1:
			ngram_pool = {}
			for letter in Letters.LETTERS.keys():
				if is_ngram_valid(letter,letter_pool):
					ngram_pool[letter] = Letters.LETTERS[letter]
		
		
		if len(ngram_pool.keys()) < 1:
			tile.randomize_face([], rng.spell, false)
			tile.add_status(TileStatus.MYSTERY, rng.spell.randi())
			tile.add_status(TileStatus.FROZEN)
			tile.add_poofcloud(tile.get_color())
			return
		
		ngram_choice = rng.spell.weighted_random(ngram_pool)
		tiles_to_remove.erase(tile)
		
		
		var option_count: int = Game.balance.mystery_options
		
		
		var remaining_ngram_options = ngram_pool.duplicate()
		remaining_ngram_options.erase(ngram_choice)
		var chosen_ngram_options : Array[String] = [ngram_choice]
		for i in range(option_count - 1):
			if len(remaining_ngram_options) == 0:
				break
			var decoy_ngram = rng.spell.weighted_random(remaining_ngram_options)
			chosen_ngram_options.append(decoy_ngram)
			remaining_ngram_options.erase(decoy_ngram)
		
		(chosen_ngram_options.shuffle())
		var sseed = rng.spell.randi()
		
		const DESTRUCTION_TIME := .56
		
		AudioManager.play_sound(Sounds.GENERIC.APPLY_STATUS,1.)
		
		var spell_out_ngram_on_tile = func(tile: Tile, ngram: String) -> void:
			var spelling_interval := 0.1
			
			for i in len(ngram):
				tile.set_face(ngram.substr(0,i+1))
				#AudioManager.play_sound(Sounds.UI.TEXT_TYPING,1.)
				AudioManager.play_sound(Sounds.TILE.FROZEN,1.,0.5)
				tile.add_status(TileStatus.MYSTERY,sseed, chosen_ngram_options)
				await Game.timeout(spelling_interval)
		#(func () -> void:
			#await Game.timeout(DESTRUCTION_TIME)
			#spell_out_ngram_on_tile.call(tile,ngram_choice)
		#).call()
		await tile_board.remove_tiles(tiles_to_remove, {
			interval = minf(0.1,DESTRUCTION_TIME/len(tiles_to_remove)), 
			poof_blend = Globals.COLORS.BLOOD, 
			restock = true, 
			tile_color = true, 
			sound = Sounds.TILE.BLEED.merged({
				VOLUME=0.4,
				PITCH_VARIANCE = 0.1, 
			})
		})
		tile.add_status(TileStatus.FROZEN)
		await spell_out_ngram_on_tile.call(tile,ngram_choice)
		#tile.add_poofcloud(tile.get_color())
	else:
		tile.set_face("aaa", true, false)


func is_tile_selectable(tile: Tile) -> bool:
	return (
		tile.is_face_modifiable()
		and not (
			tile.has_status(TileStatus.MYSTERY)
		) and not (
			tile.has_status(TileEffect.SHIMMERING)
		) and not (
			tile.has_harmful_status()
		) and not (
			tile.has_status(TileStatus.FROZEN) and len(tile.face) == 3
		)
	)
