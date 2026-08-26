extends Sprite2D

var should_be_evil := false

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	frame = 1 if should_be_evil else 0


var purr_points := 0.


const shake_threshold := .0

func _physics_process(delta: float) -> void:
	purr_points = max(0,purr_points-delta*.75)
	audio_stream_player.volume_linear = lerpf(0.,.25,purr_points)
	audio_stream_player.pitch_scale = lerpf(1.,1.25 if !should_be_evil else .75,purr_points)
	
	var time := Time.get_ticks_msec()/1000.
	
	var silly_coefficient := inverse_lerp(
			-1,1,sin(time*5.)
		)
	var silly_coefficient_b := inverse_lerp(shake_threshold,1.,purr_points)
	
	scale = Vector2.ONE*lerp(1.,.94,silly_coefficient_b)
	if purr_points > shake_threshold:
		rotation_degrees = lerp(
			-1.4,1.4,silly_coefficient
		)*silly_coefficient_b
	else:
		rotation_degrees = 0
	
func _on_pet_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseMotion:
		purr_points = min(1.,purr_points+sqrt(event.relative.length()/5090.))
	
