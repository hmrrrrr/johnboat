@tool
extends AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	play()
	animation_player.play("yay")

func kill() -> void:
	queue_free()
