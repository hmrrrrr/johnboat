extends Spell
class_name Datamosh

const CHARS_BY_RARITY = """\
qjxzwkvfybhgmp9udcl5otnrais8e24367\
"""

func set_status_tooltips():
	status_tooltips = [TileStatus.CURSED,TileEffect.NUMBER]

func has_valid_word() -> bool:
	var words: WordList = word_builder.get_words()
	return word_builder.can_submit_tiles() and word_builder.can_submit_words(words) and words.sub_lists.size() == 1 and word_builder.tiles.size() >= 1

func get_target_tiles():
	return word_builder.tiles.duplicate()

const SOUNDS = {
	DATAMOSH=preload("res://mods/mutagenic/sounds/datamosh.wav"),
	DATAMOSH_VAR1=preload("res://mods/mutagenic/sounds/datamosh1.wav"),
	DATAMOSH_VAR2=preload("res://mods/mutagenic/sounds/datamosh2.wav"),
	DATAMOSH_VAR3=preload("res://mods/mutagenic/sounds/datamosh3.wav"),
	DATAMOSH_VAR4=preload("res://mods/mutagenic/sounds/datamosh4.wav"),
}
const DATAMOSH_EFFECT = preload("res://mods/mutagenic/source/datamosh/datamosh_effect_instance.tscn")


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

	AudioManager.play_sound(SOUNDS.DATAMOSH)

	var apply_to = get_target_tiles()
	rng.spell.shuffle(apply_to)
	var last_effect: GenericTileEffect
	for tile : Tile in apply_to:
		if is_tile_selectable(tile):
			var do_curse = !tile.has_status(TileStatus.CRIT)
			#tile.add_poofcloud(tile.get_color())
			var inst := DATAMOSH_EFFECT.instantiate() as GenericTileEffect
			inst.do_play_sound = func():
				AudioManager.play_sound(
					SOUNDS["DATAMOSH_VAR%d"%randi_range(1,4)],randf_range(0.5,1.5)
				)
			inst.frame_coords = tile.tile_sprite.base_sprite.frame_coords
			tile.tile_sprite.add_child(inst)
			inst.atlas = tile.tile_sprite.base_sprite.texture
			inst.dont_change = !do_curse
			inst.bounce.connect(
				func():
					tile.animation.play("shake"))
			inst.change_number.connect(
				func():
					set_tile_face_to_corresponding_numbers(tile))
			await Game.timeout(0.05)
			if do_curse:
				tile.add_status(TileStatus.CURSED)
			last_effect = inst
		else:
			tile.animation.play("shake")
	
	await last_effect.effect_finished
	_post_use()




func is_usable():
	return super.is_usable() and has_valid_word() and any_tile_selectable(get_target_tiles())


func is_tile_selectable(tile: Tile) -> bool:
	return tile.has_face()
