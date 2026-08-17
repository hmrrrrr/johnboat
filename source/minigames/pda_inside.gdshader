shader_type canvas_item;

#include "res://source/shaders/hsv.gdshaderinc"

uniform sampler2D gradient : filter_nearest, repeat_enable;

uniform float threshold : hint_range(0.0, 1.0, 0.1);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	float v = min(rgb_to_hsv(COLOR.rgb).b/3.,1.);
	v = 1.-v;
	v = v*v*v;
	v = 1.-v;
	float t = TIME*.66;
	COLOR = texture(gradient,vec2(v,t));
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
