extends CustomStatus

static func _static_init() -> void:
	face_color=[Color("#141414"), Color("#141414")]
	deboss_color=[Color("ada9a8"),Color("ada9a8")]
	wood_textures=[preload("res://mods/mutagenic/arte/mutagen_tile/mutagen_wood_tile.png")]
	plastic_texture=preload("res://mods/mutagenic/arte/mutagen_tile/mutagen_plastic_tile.png")
	wood_fish_textures=[
		[preload("res://mods/mutagenic/arte/mutagen_tile/mutagen_wood_fish_flipped.png")],
		[preload("res://mods/mutagenic/arte/mutagen_tile/mutagen_wood_fish.png")]
	]
	plastic_fish_textures=[
		preload("res://mods/mutagenic/arte/mutagen_tile/mutagen_plastic_fish_flipped.png"),
		preload("res://mods/mutagenic/arte/mutagen_tile/mutagen_plastic_fish.png")
	]

func update_frame():
	super.update_frame()
	tile.set_instance_shader_parameter("mutagen_enabled",true)
