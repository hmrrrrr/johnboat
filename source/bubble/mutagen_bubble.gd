extends Sprite2D

var bound_tile: Tile


func _physics_process(_delta: float) -> void:
	if bound_tile:
		global_position = bound_tile.global_position
	else:
		queue_free()

func _ready() -> void:
	await get_tree().physics_frame
	bound_tile.tree_exiting.connect(
		func():
			queue_free()
	)
	show()
