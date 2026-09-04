extends TileModifierSpell

const FOREIGN_1 = preload("res://sounds/freezer/foreign1.wav")
var mimicking_spell_id := ""

func set_status_tooltips():
	status_tooltips = [TileStatus.ETERNAL, TileStatus.HOLE]

func _ready() -> void:
	Game.player.health_changed.connect(_on_player_health_changed)

func _on_player_health_changed() -> void:
	if Game.player.health <= 3 and Game.player.health > 0:
		add_charge(1)

func apply_to_tile(tile: Tile, _real_tile: Tile, is_preview: bool, _is_preview_update: bool) -> void :
	tile.apply_hole( not is_preview)
	tile.add_status(TileStatus.ETERNAL)
	if not is_preview:
		AudioManager.play_sound(FOREIGN_1,1.,.7,)
		tile.add_poofcloud(tile.get_color())


func is_tile_selectable(tile: Tile) -> bool:
	return (
		!tile.has_status(TileStatus.HOLE)
	)
