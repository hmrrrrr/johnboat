extends TileModifierSpell

enum CatchyMode {
	SEQUENTIAL, #ex. 3456
	SEQUENTIAL_REVERSED, #ex. 7654
	DUPED_SINGLE, #ex. 8888
	DUPED_DOUBLE, #ex. 3939
	MODE_MAX
}

const CATCHY_NUMBER_EFFECT_INSTANCE = preload("res://mods/johnboat/source/spells/catchy_number/catchy_number_effect_instance.tscn")


var number_sequence: Array[String] : get=generate_number_sequence
const CATCHY_NUMBER_DELAY_CURVE: Curve = preload("res://mods/johnboat/source/resources/catchy_number_delay_curve.tres")

static var STA_DEBUG_SEED := 0
var DEBUG_SEED := 0

const DO_DEBUG_SET_SEED := true

func _spell_init():
	if OS.has_feature("debug") and DO_DEBUG_SET_SEED:
		DEBUG_SEED = STA_DEBUG_SEED
		STA_DEBUG_SEED += 1

func _first_spawn(is_transform: = false) -> void:
	super(is_transform)

func get_sequence_seed() -> int:
	if OS.has_feature("debug") and DO_DEBUG_SET_SEED:
		return DEBUG_SEED
	return Game.main.rng.spell.seed

func generate_number_sequence() -> Array[String]:
	
	var num_rng = RNG.new()
	num_rng.state = 0
	num_rng.seed = get_sequence_seed()
	
	var catchy_mode := num_rng.randi()%CatchyMode.MODE_MAX as CatchyMode
	if catchy_mode in [CatchyMode.SEQUENTIAL, CatchyMode.SEQUENTIAL_REVERSED]:
		var starting_num_index: int = num_rng.randi()%(len(Letters.NUMBERS)-3)
		var arr: Array[String] = Letters.NUMBERS.slice(starting_num_index,starting_num_index+4)
		if catchy_mode == CatchyMode.SEQUENTIAL_REVERSED:
			arr.reverse()
		return arr
	
	var the_num: String = Letters.NUMBERS[num_rng.randi()%(len(Letters.NUMBERS))]
	if catchy_mode == CatchyMode.DUPED_DOUBLE:
		var remaining_nums := Letters.NUMBERS.duplicate()
		remaining_nums.erase(the_num)
		var the_second_num: String = remaining_nums[num_rng.randi()%len(remaining_nums)]
		return [the_num,the_second_num,the_num,the_second_num]
		
	return [the_num,the_num,the_num,the_num]
	
	

func get_tooltip_context():
	return {
		number_list = number_sequence
	}
	
func set_status_tooltips():
	var description = ""
	var already_processed = []
	var seq = generate_number_sequence()
	for number in seq:
		if !(number in already_processed):
			var number_description = StringManager.get_string("status/number/specific_description", {number = number, letters = Letters.NUMPAD_CHARACTERS[number]})
			description += number_description + "\n"
			already_processed.append(number)
	status_tooltips = [
		TileStatus.SPICY, 
		{status="special_number_sequence",string_lines=description}
	]

func apply_from_number_sequence(tile: Tile, i: int, fx_rng: RNG) -> void:
	assert(i < len(number_sequence))
	tile.set_face(number_sequence[i])
	var next_tile := tile.get_board_neighbor(Vector2.RIGHT)
	fx_rng
	tile.animation.play("pressed")
	AudioManager.play_sound(
		fx_rng.pick_random(Sounds.PROLE_SERVICE.TONE.SOUNDS),
		1.,
		.5
		)
	AudioManager.play_sound(
		Sounds.GENERIC.APPLY_STATUS
	)
	
	
	var inst := CATCHY_NUMBER_EFFECT_INSTANCE.instantiate() as GenericTileEffect
	inst.do_play_sound = func():
		#AudioManager.play_sound(
			#SOUNDS["DATAMOSH_VAR%d"%randi_range(1,4)],randf_range(0.5,1.5)
		#)
		pass
	inst.frame_coords = tile.tile_sprite.base_sprite.frame_coords
	tile.tile_sprite.add_child(inst)
	inst.atlas = tile.tile_sprite.base_sprite.texture
	inst.dont_change = false
	inst.bounce.connect(
		func():
			pass
	)
	
	tile.add_status(TileStatus.SPICY)
	
	if next_tile and (i+1 < len(number_sequence)):
		var delay_time := CATCHY_NUMBER_DELAY_CURVE.sample(fx_rng.randf())
		delay_time = snappedf(delay_time,.033333)
		await Game.timeout(delay_time)
		await apply_from_number_sequence(next_tile, i+1,fx_rng)

func apply_to_tile(tile: Tile, _real_tile: Tile, is_preview: bool, _is_preview_update: bool) -> void :
	if not is_preview:
		var fx_rng := RNG.new()
		fx_rng.state = 0
		fx_rng.seed = get_sequence_seed()
		tile.add_poofcloud(tile.get_color())
		await apply_from_number_sequence(tile,0,fx_rng)
	else:
		tile.add_status(TileStatus.SPICY)
		tile.set_face(number_sequence[0])
	


func is_tile_selectable(tile: Tile) -> bool:
	return (
		tile.is_face_modifiable() and 
		!tile.has_harmful_status() and 
		!tile.has_effect(TileEffect.SHIMMERING) and 
		tile.has_face()
	)
