extends Spell
class_name Milk

func set_status_tooltips():
	status_tooltips = [{status = TileStatus.ENHANCED, wooden = true}]

func has_valid_word() -> bool:
	var words: WordList = word_builder.get_words()
	var repeat_word := word_builder.get_repeat_word(words)
	return repeat_word != "" and word_builder.can_submit_tiles() and word_builder.can_submit_words(words) and words.sub_lists.size() == 1

func get_target_tiles():
	return word_builder.tiles.duplicate()

const SOUNDS = {
	MILKSPILL = preload("res://mods/johnboat/sounds/milkspill.wav")
	
}
const MILK_EFFECT = preload("res://mods/johnboat/source/spells/milk/milk_effect_instance.tscn")

func _ready() -> void:
	charge_updated.connect(
		func():
			frame_updated.emit()
	)

func _use():
	if not has_valid_word():
		_end_use()
		return

	AudioManager.play_sound(SOUNDS.MILKSPILL)

	var apply_to = get_target_tiles()
	#rng.spell.shuffle(apply_to)
	var last_effect: GenericTileEffect
	for tile : Tile in apply_to:
		if is_tile_selectable(tile):
			var do_milk = (!tile.has_status(TileStatus.CRIT)) and (tile.type == TileType.DAMAGE)
			#tile.add_poofcloud(tile.get_color())
			var inst := MILK_EFFECT.instantiate() as GenericTileEffect
			inst.do_play_sound = func():
				#AudioManager.play_sound(
					#SOUNDS["DATAMOSH_VAR%d"%randi_range(1,4)],randf_range(0.5,1.5)
				#)
				pass
			inst.frame_coords = tile.tile_sprite.base_sprite.frame_coords
			tile.tile_sprite.add_child(inst)
			inst.atlas = tile.tile_sprite.base_sprite.texture
			inst.dont_change = !do_milk
			inst.bounce.connect(
				func():
					if !do_milk:
						#tile.animation.play("shake")
						pass
					)
						
			await Game.timeout(0.015)
			if do_milk:
				tile.add_status(TileStatus.ENHANCED)
			last_effect = inst
		else:
			tile.animation.play("shake")
	
	await last_effect.effect_finished
	_post_use()
	
	frame_updated.emit()

func is_usable():
	return super.is_usable() and has_valid_word() and any_tile_selectable(get_target_tiles())


func get_hv_frames() -> Vector2i:
	return Vector2i(2, 1)


func get_frame() -> int:
	return 0 if charge == 0 else 1


func is_tile_selectable(tile: Tile) -> bool:
	return true
