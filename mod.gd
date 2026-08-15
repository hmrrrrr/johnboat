extends Mod
class_name MutagenicMod
const MUTAGEN_BUBBLES = preload("uid://xd5bu6sw7c6k")

var remove_other_enemies:=true
var exisiting_enemy_pool:Array[String]

func _ready() -> void:
	CustomIntent.custom_status_intent_icons["mutagen"]=preload("uid://dukxvsrifradw")
	update_remove_other_enemies()
	
	
	await Game.main_scene_loaded
	Game.main.game_state_updated.connect(_game_state_updated)

func update_remove_other_enemies():
	if exisiting_enemy_pool==null:
		exisiting_enemy_pool=EnemyLoader.enemy_pools[0][0]
	
	if remove_other_enemies:
		EnemyLoader.enemy_pools[0][0].clear()
	else:
		for enemy in Enemies.POOLS[0][0]:
			if enemy not in EnemyLoader.enemy_pools[0][0]:
				EnemyLoader.enemy_pools[0][0].append(enemy)
	if "dimorph" not in EnemyLoader.enemy_pools[0][0]:
		EnemyLoader.add_enemy("dimorph",0,0,"res://mods/mutagenic/dimorph/miniface_dimorph.png")
		
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
