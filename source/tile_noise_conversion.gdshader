shader_type canvas_item;

instance uniform vec4 initial_frame;
instance uniform vec4 ending_frame;

instance uniform float progress : hint_range(0.0, 1.0, .2);

uniform sampler2D noise : filter_nearest;

uniform float edge_feather : hint_range(0.0,0.5);

uniform bool enable_glow = true;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 uv = (UV)/(initial_frame.zw);
	float noise_progress = texture(noise, SCREEN_UV).r;
	vec2 uv_target = initial_frame.xy + initial_frame.zw*uv;
	float noise_target = progress*(1.+edge_feather*2.)-edge_feather;
	
	bool glow = false;
	if(noise_progress < noise_target) {
		uv_target = ending_frame.xy + ending_frame.zw*uv;
	} else if (enable_glow) {
		if (noise_progress*0.8 < noise_target) {
			glow = true;
		}
	}
	
	COLOR = texture(TEXTURE,uv_target);
	if (glow) {
		COLOR.r = 1.;	
	}
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
