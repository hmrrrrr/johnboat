extends "res://source/tile_status/mystery.gd"

var cold_case_face_options: Array[String]

func get_save_data():
	var data = {}
	data["cold_case_face_options"] = cold_case_face_options
	data["mystery_seed"] = mystery_seed
	return data

func load_save_data(data):
	mystery_seed = data.mystery_seed
	cold_case_face_options = data.cold_case_face_options

func apply(_mystery_seed: int = Game.random.randi(), _cold_case_face_options: Array[String] = []):
	super(_mystery_seed)
	cold_case_face_options = _cold_case_face_options

func get_tooltip_context():
	var face = tile.face
	var face_length = len(face)
	if len(cold_case_face_options) == 0:
		return super()
	

	return {faces = cold_case_face_options}
	
