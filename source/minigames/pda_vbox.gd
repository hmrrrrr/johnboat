extends VBoxContainer

func _ready() -> void:
	reparent($"../../SubViewport")
	position = Vector2.ZERO
