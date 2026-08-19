shader_type canvas_item;

uniform vec4 party_blue : source_color;

vec4 overlay(vec4 base, vec4 blend){
	vec4 limit = step(0.5, base);
	return mix(2.0 * base * blend, 1.0 - 2.0 * (1.0 - base) * (1.0 - blend), limit);
}

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	COLOR = overlay(COLOR,party_blue);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
