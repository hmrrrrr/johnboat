extends Node2D
class_name BandageEffectInstance

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var bandage_sprite: Sprite2D = $Mask/BandageSprite
signal applied
func _ready() -> void:
	animation_player.play("apply")
	bandage_sprite.rotation_degrees = randf_range(-22,22)
	bandage_sprite.position += get_local_mouse_position().clamp(Vector2(-4,-4),Vector2(4,4))
