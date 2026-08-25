extends Node2D
class_name GenericTileEffect
@onready var tile_sprite: TileSprite = $".."
@onready var base_sprite_anim_player: AnimationPlayer = $"../BaseSpriteAnimPlayer"
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var fake_sprite: Sprite2D = $FakeSprite

var frame_coords: Vector2
var atlas: Texture2D
var dont_change: bool

var do_play_sound: Callable

signal play_sound
signal bounce
signal effect_finished

@export var default_ending_frame = Vector4(64,0.,32,32)

func _ready() -> void:
	show()
	await get_tree().process_frame
	do_datamosh_effect()
	
func do_datamosh_effect() -> void:
	var starting_frame_coords: Vector2 = frame_coords*32
	var starting_frame = Vector4(
		starting_frame_coords.x,starting_frame_coords.y,
		32,32,
	)
	var atlas_size : Vector2 = atlas.get_size()
	starting_frame.x /= atlas_size.x
	starting_frame.y /= atlas_size.y
	starting_frame.z /= atlas_size.x
	starting_frame.w /= atlas_size.y
	var ending_frame = default_ending_frame
	ending_frame.x /= atlas_size.x
	ending_frame.y /= atlas_size.y
	ending_frame.z /= atlas_size.x
	ending_frame.w /= atlas_size.y
	
	#var params := RenderingServer.canvas_item_get_instance_shader_parameter_list(fake_sprite)
	#
	#var sprite_does_frame_animation := "initial_frame" in params and "ending_frame" in params
	#
	var unchanging = starting_frame == ending_frame
	if !unchanging:
		tile_sprite.bomb_overlay.modulate = Color(1,1,1,0)
	tile_sprite.base_sprite.hide()
	fake_sprite.texture = atlas
	
	if dont_change:
		ending_frame = starting_frame
	
	animation_player.play("tile_change")
	fake_sprite.set_instance_shader_parameter("initial_frame",starting_frame)
	fake_sprite.set_instance_shader_parameter("ending_frame",ending_frame)
	
	await play_sound
	
	do_play_sound.call()

	await animation_player.animation_finished
	
	tile_sprite.base_sprite.show()
	hide()
	if !unchanging:
		get_tree().create_tween().tween_property(tile_sprite.bomb_overlay, "modulate", Color.WHITE, .2)
	effect_finished.emit()
	queue_free()
	
	
