extends ArcingProjectile
class_name EggshellEffect

var mask_frame := 0
var atlas: Texture2D
var atlas_frame := 0
@onready var mask: Sprite2D = $MaskA
@onready var mask_b: Sprite2D = $MaskB
var bound_node : Node2D


@onready var tile_sprite: Sprite2D = $MaskA/TileSprite
@onready var tile_sprite_b: Sprite2D = $MaskB/TileSprite

var pre_split := true

const CRACK_DELAY := 0.3

func _process(delta):
	if mask.frame == 5:
		global_position = bound_node.global_position
		global_rotation = bound_node.global_rotation

func _ready():
	gravity = 0
	mask.frame = 5
	
	tile_sprite.texture = atlas
	tile_sprite.frame = atlas_frame
	
	tile_sprite_b.texture = atlas
	tile_sprite_b.frame = atlas_frame
	
	mask_b.frame = mask_frame
	
	
	await Game.timeout(CRACK_DELAY)
	gravity = 800
	
	mask.frame = mask_frame + 3
	
	
	var direction_sign: = -1 if mask_frame == 0 else 1
	
	var bounce_offset: = 165
	
	var tdest = Vector2(global_position.x + bounce_offset * direction_sign, 290)
	
	launch(global_position, tdest, 23)
	look_at_direction = false
	angular_velocity = PI * 1.17 * direction_sign
	angular_deceleration = PI * 1.8
	decelerate_to = PI * .3 * direction_sign
	do_poof = false
	free_on_impact = false
	
	await Game.timeout(3)
	queue_free()
