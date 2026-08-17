class_name PDAMinigame extends Minigame


@onready var pda: NinePatchRect = %PDA
@onready var addict_timer: Label = %AddictTimer

@onready var put_away_sprite: Sprite2D = %PutAwaySprite
@onready var put_away_tooltip = %PutAwayButtonTooltip

@onready var anim_player = %AnimPlayer

@onready var time_label: RichTextLabel = $BoardOffset/PDA/SubViewport/VBoxContainer/TopRow/TimeLabel
@onready var news_label: RichTextLabel = $BoardOffset/PDA/SubViewport/VBoxContainer/TopRow/NewsLabel
@onready var misc_info_label: RichTextLabel = $BoardOffset/PDA/SubViewport/VBoxContainer/MiscInfo/MiscInfoLabel

var colon_parity = 1
const news_text = """\
THE WHOLE CONTINENT NOW FALLS VICTIM TO ONSLAUGHT OF DRIVING WINDS, HEAVY RAINS AND SWOLLEN RIVERS           \
WITH MILLIONS HOMELESS, SCORES OF FLOODSTRUCK PEOPLE DIE           \
"""

#var APPROVED_WORDS = """\
#control
#party
#safety
#morals
#classes
#prole
#prisoner
#domestication
#regime
#joyless
#pornography
#cripple
#hate
#work
#menstruation
#faggot
#state
#bureau\
#""".split("\n")

const APPROVED_WORDS = {
	"remember to be"=
		[
			"joyless",
			"quiet",
			"envious",
			"hungry",
			"prisoner",
			"moral",
			"domestic"
		],
	"object"=
		[
			"faggotry",
			"sex",
			"thoughtfulness",
			"freedom"
		],
	"respect your"=
		[
			"state",
			"bureau",
			"Party",
			"domestication",
			"class",
			"safety"
		],
	"remember to"=
		[
			"work",
			"starve",
			"hate",
			"menstruate"
		],
	"don't spell"=
		[
			"albatross"
		]
}

var news_progression := 0

func get_next_spell():
	var spell_pool = Game.main.spell_pool
	if spell_pool.size() < 2:
		Game.main.fill_spell_pool()
		return get_next_spell()

	var pool_copy = spell_pool.duplicate()


	if pool_copy.is_empty():
		Game.main.fill_spell_pool()
		return get_next_spell()

	var rng = RNG.new()
	rng.seed = Game.main.rng.spell.seed
	rng.state = Game.main.rng.spell.state
	var spell_id = rng.weighted_random(pool_copy)

	return spell_id



func board_has_word(tiles: Array[Tile], word: String):
	for tile in tiles:
		if not (tile.is_shimmering()):
			for i in range(1,5):
				if tile.face == word:
					return true
				if tile.face == word.substr(0,i):
					var t2 = tiles.duplicate()
					t2.erase(tile)
					if board_has_word(t2,word.substr(i)):
						return true
	return false

func get_next_enemy():
	var expected_enemies = Game.main.get_expected_run_enemies()
	var current_enemy = Game.main.enemy.id
	
	print(expected_enemies)
	print(current_enemy)

func _ready():
	news_progression = (Time.get_ticks_msec() / 200)
	
	misc_info_label.text = """[color=white]\
Next spell: %s\
Next enemy:\
"""%[StringManager.get_string("spell/%s/name"%get_next_spell())]
	get_next_enemy()

func appear(instant: = false) -> void :
	addict_timer.visible = Game.player.id == Globals.CHARACTERS.ADDICT
	update_time()
	
	await Game.tile_board.slide_out(true)
	await Game.conditional_timeout(0.16, instant)
	await anim_player.play_until_finished("appear", instant)


func disappear(instant: = true) -> void :
	await anim_player.play_until_finished("disappear", instant)
	await Game.conditional_timeout(0.16, instant)
	await Game.tile_board.slide_in(instant)


func cancel() -> void :
	AudioManager.play_sound(Sounds.UI.WORD_SUBMIT)
	finished.emit()


func confirm() -> void :
	AudioManager.play_sound(Sounds.UI.WORD_SUBMIT)
	finished.emit()


func handles_right_stick() -> bool:
	return false


func has_left_stick_targeting() -> bool:
	return false


func get_left_stick_center() -> Vector2:
	return global_position




func get_addict_timer() -> Label:
	return addict_timer


func _on_confirm_button_pressed() -> void :
	confirm()

func update_time() -> void:
	var time_dict = Time.get_time_dict_from_system()
	var military_time = "[color=white]%02d%s:[color=white]%02d" % [time_dict.hour,"[color=black]" if colon_parity == 1 else "", time_dict.minute]
	time_label.text = military_time
	colon_parity = (colon_parity+1)%2
	
func _on_current_time_timer_timeout() -> void:
	update_time()

func _on_news_timer_timeout() -> void:
	news_label.text = "[color=white]%s[/color]"%(news_text.substr(news_progression) + news_text.substr(0,news_progression))
	
	
	news_progression = (news_progression+1)%len(news_text)
