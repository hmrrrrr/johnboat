extends Node2D
class_name PawStampEffect

var should_be_plant := false

signal apply
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	animation_player.play("stamp")
	#sprite_2d.rotation = randi_range(0,3)*(PI/2.)
	if should_be_plant:
		sprite_2d.frame = 1
		sprite_2d.rotation = randf_range(0,TAU)#randi_range(0,3)*(PI/2.)
		sprite_2d.material.blend_mode = 0
		
func kill():
	queue_free()
	hide()
