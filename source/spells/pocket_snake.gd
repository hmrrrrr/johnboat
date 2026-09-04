extends Spell

const SNAKE_SEGMENT = preload("res://mods/johnboat/source/spells/snake_segment.tscn")


func create_segment(tile: Tile) -> SnakeSegment:
	var segment := SNAKE_SEGMENT.instantiate() as SnakeSegment
	tile.tile_sprite.add_child(segment)
	
	
	return segment

var on_first_tile := true

var tiles: Array[Tile] = []


func get_tooltip_context():
	return {
		"selecting_first_tile" = on_first_tile
	}

func _use():
	var segments: Array[SnakeSegment] = []
	tiles = []
	var can_continue_snaking := true
	on_first_tile = true
	const violence_interval = 0.0833
	var destroy_segments := func(violent = false):
		for tile in tiles:
			tile.state = Tile.State.IDLE
			tile.update_z_index()
			
			
			tile.hover_handler.set_disabled(false,true)
			
		var last_signal
		for i in range(len(segments)):
			var segment = segments[i]
			var tile = tiles[i]
			last_signal = segment.die_animation()
			last_signal.connect(
				func():
					segment.parent_scale = Vector2.ONE
					segment.queue_free()
					if violent:
						AudioManager.play_sound(Sounds.GENERIC.BLOOD_EXPLODE,1.15,.5)
						var bomb_status = tile.get_status(TileStatus.BOMB)
						if bomb_status:
							await bomb_status.explode(false,true)
						else:
							tile.add_poofcloud(Color("#36753a"),Globals.COLORS.BLOOD,false)
						tile_board.remove_tile_from_board(tile)
						tile.clear()
			)
			if violent:
				await Game.timeout(violence_interval)
		if last_signal and last_signal.get_object():
			await last_signal
	
	var pitch := 1.
	while can_continue_snaking:
		var chosen_tile = await get_selection(tiles)
		if chosen_tile == null:
			
			destroy_segments.call()
			_end_use()
			return
			
		var relative_to_last_direction := Vector2i.ZERO
		var prev_tile : Tile
		var prev_segment : SnakeSegment
		if !on_first_tile:
			prev_tile = tiles[-1]
			prev_segment = segments[-1]
			relative_to_last_direction = chosen_tile.get_coord() - prev_tile.get_coord()
			relative_to_last_direction *= Vector2i(1,-1)
			prev_segment.update_state(Vector2i.ZERO, len(tiles) == 1)
		
		
		tiles.append(chosen_tile)
		chosen_tile.hover_handler.set_disabled(true,true)
		#chosen_tile.animation.play("reroll")
		
		# TODO 
		# MAKE THIS SHIT GOOD. GET RID OF Z INDEX FUCKERY AND
		# JUST USE THE TILE'S BASE Z INDEX, PUTTING THE CONNECTION OVERLAY
		# ON THE PRESIDING TILE
		
		chosen_tile.state = Tile.State.REMOVING
		var segment := create_segment(chosen_tile)
		segments.append(segment)
		AudioManager.play_sound(Sounds.BOOKWORM.MILKWORM_FIREBALL,pitch)
		pitch *= 1.05946309436
		if prev_tile:
			var presiding_segment := prev_segment
			var connection_direction := relative_to_last_direction
			if (chosen_tile.z_index > prev_tile.z_index):
				presiding_segment = segment
				connection_direction *= -1
			
			presiding_segment.add_connection_overlay(connection_direction)
		
		if on_first_tile:
			on_first_tile = false
			update_banner_label()
		else:
			segment.update_state(relative_to_last_direction)
		
		var valid_neighbors := chosen_tile.get_board_neighbors().filter(
			func(t: Tile): return t not in tiles
		)
		if len(valid_neighbors) == 0:
			can_continue_snaking = false
		if chosen_tile.has_any_status(
			[TileStatus.BOMB,TileStatus.POISON,TileStatus.CURSED,TileStatus.ETERNAL]
		):
			can_continue_snaking = false
	segments[-1].make_face_dead()
	var playback := AudioManager.play_sound(Sounds.ANTI_SEX_WORKER.CRAMP,1.3)
	await Game.timeout(1.)
	await destroy_segments.call(true)
	
	
	playback.stop()
	
	await tile_board.settle_board()
	await tile_board.fill_board()
	

	_post_use()


func is_tile_selectable(tile: Tile) -> bool:
	return ( 
		on_first_tile or
		((tile not in tiles) and tile in tiles[-1].get_board_neighbors())
	)
