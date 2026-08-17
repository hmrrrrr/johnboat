extends Spell


func set_status_tooltips():
	status_tooltips = [TileStatus.CURSED,TileEffect.NUMBER]

func has_valid_word() -> bool:
	var words: WordList = word_builder.get_words()
	return word_builder.can_submit_tiles() and word_builder.can_submit_words(words) and words.sub_lists.size() == 1 and word_builder.tiles.size() >= 1

func get_target_tiles():
	return word_builder.tiles.duplicate()

const DATAMOSH_EFFECT = preload("uid://dsrrhj6sxkvad")


func set_tile_face_to_corresponding_numbers(tile: Tile):
	var new_face = ""
	for letter in tile.face:
		var found = false
		for number in Letters.NUMPAD_CHARACTERS.keys():
			var corresponding_letters = Letters.NUMPAD_CHARACTERS[number]
			if letter in corresponding_letters:
				new_face += (number)
				found = true
		
		if !found:
			new_face += letter
	tile.set_face(new_face)

func _use():
	if not has_valid_word():
		_end_use()
		return

	AudioManager.play_sound(Sounds.SPELLS.SPRAY_SHORT)

	var apply_to = get_target_tiles()
	rng.spell.shuffle(apply_to)
	for tile : Tile in apply_to:
		if is_tile_selectable(tile):
			var do_curse = !tile.has_status(TileStatus.CRIT)
			#tile.add_poofcloud(tile.get_color())
			var inst = DATAMOSH_EFFECT.instantiate()
			inst.frame_coords = tile.tile_sprite.base_sprite.frame_coords
			tile.tile_sprite.add_child(inst)
			inst.atlas = tile.tile_sprite.base_sprite.texture
			inst.keeping_crit = !do_curse
			await Game.timeout(0.05)
			if do_curse:
				tile.add_status(TileStatus.CURSED)
			set_tile_face_to_corresponding_numbers(tile)
		else:
			tile.animation.play("shake")

	_post_use()




func is_usable():
	return super.is_usable() and has_valid_word() and any_tile_selectable(get_target_tiles())


func is_tile_selectable(tile: Tile) -> bool:
	return tile.has_face()
