@tool
extends EditorScript


func _run():
	export_image("res://mods/mutagenic/source/minigames/pda_gradient.tres")
	pass

func export_image(path: String):
	var file := load(path) as Texture2D
	if file:
		file.get_image().save_png("res://mods/mutagenic/source/editor_scripts/img_export/output.png")
