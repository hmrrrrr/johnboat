@tool
extends Mod
class_name JohnboatMod
const MUTAGEN_BUBBLES = preload("uid://xd5bu6sw7c6k")


var SPELLS: Dictionary[String, String] = {
	PDA = "pda",
	PHOTO_ALBUM = "photo_album",
	
	
	DATAMOSH = "datamosh",
	SUPERPOSITION = "superposition",
	BOOSTER_SHOT = "booster_shot",
	TOY_CAMERA = "toy_camera",
	MILK = "milk",
	ZIPTIES = "zipties",
	GAYDAR = "gaydar",
	WHODUNIT = "whodunit",
	CAT_TAIL = "cat_tail",
	BLT = "blt",
	DISSENTER_HOTLINE = "dissenter_hotline",
	SUBDOMAIN = "subdomain"
}

const BASE_WEIGHT := 5.

var SPELL_POOL: Dictionary[String, float] = {
	SPELLS.TOY_CAMERA: BASE_WEIGHT,
	SPELLS.DATAMOSH: BASE_WEIGHT,
	SPELLS.CAT_TAIL: BASE_WEIGHT,
	SPELLS.GAYDAR: BASE_WEIGHT,
	SPELLS.PDA: 0.,
	SPELLS.PHOTO_ALBUM: 0.,
	SPELLS.SUPERPOSITION: BASE_WEIGHT,
	SPELLS.BOOSTER_SHOT: BASE_WEIGHT,
	SPELLS.MILK: BASE_WEIGHT,
	SPELLS.ZIPTIES: BASE_WEIGHT,
	SPELLS.WHODUNIT: BASE_WEIGHT,
	SPELLS.BLT: BASE_WEIGHT/2.,
	SPELLS.DISSENTER_HOTLINE: BASE_WEIGHT,
	SPELLS.SUBDOMAIN: BASE_WEIGHT,
}

var SPELL_CATEGORIES: Dictionary[String, Array] = {
	Globals.SPELL_CATEGORY.SUPPORT: [
		SPELLS.DATAMOSH,
		SPELLS.BOOSTER_SHOT,
		SPELLS.CAT_TAIL,
		SPELLS.DISSENTER_HOTLINE,
	],
	Globals.SPELL_CATEGORY.OFFENSIVE: [
		SPELLS.SUPERPOSITION,
		SPELLS.MILK,
		SPELLS.GAYDAR,
		SPELLS.SUBDOMAIN
	],
	Globals.SPELL_CATEGORY.DEFENSIVE: [
		SPELLS.TOY_CAMERA,
		SPELLS.ZIPTIES,
		SPELLS.BLT,
		SPELLS.WHODUNIT,
	],
	
	Globals.SPELL_CATEGORY.DIRECT_DEFENSE: [
		SPELLS.TOY_CAMERA,
		SPELLS.ZIPTIES,
		SPELLS.WHODUNIT,
	],
}


#static func _static_init():
	#print("trying my best")
	#Sounds.register_sounds(
		#{
			#DIMORPH={
				#SOUNDS = [
					#preload("res://mods/johnboat/overrides/sounds/dimorph/dimorph_flinch.wav"),
					#preload("res://mods/johnboat/overrides/sounds/dimorph/dimorph_flinch_parry.wav"),
					#preload("res://mods/johnboat/overrides/sounds/dimorph/dimorph_growl.wav"),
					#preload("res://mods/johnboat/overrides/sounds/dimorph/dimorph_gunkshot.wav"),
					#preload("res://mods/johnboat/overrides/sounds/dimorph/dimorph_xscissor_1.wav"),
					#preload("res://mods/johnboat/overrides/sounds/dimorph/dimorph_xscissor_2.wav"),
				#]
			#}
		#},
		#Sounds.SOUND_CONSTANTS,
		#Sounds.SOUND_GROUPS,
	#)
	#

func _ready() -> void:
	#CustomIntent.custom_status_intent_icons["mutagen"]=preload("uid://dukxvsrifradw")
	#update_remove_other_enemies()
	
	#if "dimorph" not in EnemyLoader.enemy_pools[0][0]:
		#EnemyLoader.add_enemy("dimorph",2,3,"res://mods/johnboat/arte/dimorph/miniface_dimorph.png")
		
	await Game.main_scene_loaded
	Game.main.game_state_updated.connect(_game_state_updated)

func _game_state_updated():
	if Game.word_builder != null and !Game.word_builder.has_node("MutagenBubbles"):
		var inst = MUTAGEN_BUBBLES.instantiate()
		Game.word_builder.add_child(inst)
		var word_holder = Game.word_builder.get_node("WordHolder")
		word_holder.updated_tiles.connect(inst._on_word_holder_updated_tiles)

func _post_mods_loaded() -> void :
	pass


func get_options_save_data() -> Dictionary:
	return {}


func get_save_data() -> Dictionary:
	return {}


func get_run_save_data() -> Dictionary:
	return {}

func get_spell_ids() -> Array[String]:
	return namespace_ids(SPELLS.values())
	
func get_spell_pool(category: String = "") -> Dictionary[String, float]:
	var category_pool: Array = SPELL_CATEGORIES.get(category, [])
	var pool := SpellData.get_filtered_spell_pool(SPELL_POOL, category_pool)
	return namespace_dictionary_ids(pool)
