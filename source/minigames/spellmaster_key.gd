@tool
class_name SpellmasterKey extends Node2D


signal state_changed(is_reverted)

var base_letter = ""
@export var state = false : set=set_state
var original_state = false

@onready var sprite: Sprite2D = $Sprite
@onready var button: Button = $Button
@onready var hover_handler: HoverHandler = %HoverHandler


func set_state(new_state):
	if new_state == state:
		return

	state = new_state

	if state: sprite.frame = 0
	else: sprite.frame = 1



func set_disabled(disabled: bool) -> void :
	button.disabled = disabled
	hover_handler.set_disabled(disabled)


func _on_button_pressed():
	AudioManager.play_sound(Sounds.UI.TILE_CLICK)
	set_state( not state)
