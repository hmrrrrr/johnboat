extends Sprite2D
class_name FlashFX
@onready var animation_player: AnimationPlayer = $AnimationPlayer

signal done

func kill():
	get_parent().remove_child(self)
	queue_free()

func _ready():
	animation_player.play("flash")
