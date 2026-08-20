@tool
extends Mod
class_name JohnboatMod
const MUTAGEN_BUBBLES = preload("uid://xd5bu6sw7c6k")


var SPELLS: Dictionary[String, String] = {
	DATAMOSH = "datamosh",
	SUPERPOSITION = "superposition",
	PDA = "pda",
	BOOSTER_SHOT = "booster_shot",
	TOY_CAMERA = "toy_camera",
	MILK = "milk",
	ZIPTIES = "zipties",
	GAYDAR = "gaydar",
}

var SPELL_POOL: Dictionary[String, float] = {
	SPELLS.PDA: 0.,
	SPELLS.DATAMOSH: 2.5,
	SPELLS.SUPERPOSITION: 2.5,
	SPELLS.BOOSTER_SHOT:2.5,
	SPELLS.TOY_CAMERA:2.5,
	SPELLS.MILK:2.5,
	SPELLS.ZIPTIES:2.5,
	SPELLS.GAYDAR:2.5,
}

var SPELL_CATEGORIES: Dictionary[String, Array] = {
	Globals.SPELL_CATEGORY.SUPPORT: [
		SPELLS.DATAMOSH,
		SPELLS.PDA,
		SPELLS.BOOSTER_SHOT,
	],
	Globals.SPELL_CATEGORY.OFFENSIVE: [
		SPELLS.SUPERPOSITION,
		SPELLS.MILK,
		SPELLS.GAYDAR,
	],
	Globals.SPELL_CATEGORY.DEFENSIVE: [
		SPELLS.TOY_CAMERA,
		SPELLS.ZIPTIES,
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
