shader_type canvas_item;
render_mode blend_add;
uniform float frameyness = 60;
uniform float speed = 3;

uniform float percent_visible_at_once : hint_range(0.0, 1.0);
uniform float animation_progress : hint_range(0.0, 1.0);

varying float vertex_line_progress;




void vertex() {
	float t = TIME * speed;
	t *= frameyness;
	t = t - fract(t);
	t /= frameyness;
	UV.x -= t;
	VERTEX.y += sin(t*80.+UV.x*80.)*8.;
	
	vertex_line_progress = COLOR.g;
}

void fragment() {
	float chunk_starting_position = mix(0.,1.-percent_visible_at_once,animation_progress);
	float chunk_ending_position = mix(percent_visible_at_once,1.,animation_progress);
	
	
	if (vertex_line_progress < chunk_ending_position && vertex_line_progress > chunk_starting_position) {
		COLOR = texture(TEXTURE,UV);
	} else {
		COLOR.rgb = vec3(0.);
	}
	
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
