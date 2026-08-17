extends Node2D

@onready var tile_sprite: TileSprite = $".."
@onready var base_sprite_anim_player: AnimationPlayer = $"../BaseSpriteAnimPlayer"
@onready var datamosh_animation_player: AnimationPlayer = $AnimationPlayer
@onready var fake_datamosh_sprite: Sprite2D = $FakeDatamoshSprite

var frame_coords: Vector2
var atlas: Texture2D
var keeping_crit: bool

func _ready() -> void:
	show()
	await get_tree().process_frame
	do_datamosh_effect()
	
func do_datamosh_effect() -> void:
	tile_sprite.bomb_overlay.modulate = Color(1,1,1,0)
	tile_sprite.base_sprite.hide()
	fake_datamosh_sprite.texture = atlas
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
	var ending_frame = Vector4(64,0.,32,32) # cursed tile
	ending_frame.x /= atlas_size.x
	ending_frame.y /= atlas_size.y
	ending_frame.z /= atlas_size.x
	ending_frame.w /= atlas_size.y
	
	if keeping_crit:
		ending_frame = starting_frame
	
	fake_datamosh_sprite.set_instance_shader_parameter("initial_frame",starting_frame)
	fake_datamosh_sprite.set_instance_shader_parameter("ending_frame",ending_frame)
	
	datamosh_animation_player.play("datamosh")
	await datamosh_animation_player.animation_finished
	
	
	
	tile_sprite.base_sprite.show()
	hide()
	
	get_tree().create_tween().tween_property(tile_sprite.bomb_overlay, "modulate", Color.WHITE, .2)
	
	queue_free()
	
