shader_type canvas_item;

instance uniform vec4 initial_frame;
instance uniform vec4 ending_frame;

instance uniform float progress : hint_range(0.0, 1.0, .2);
instance uniform float gradient_progress : hint_range(0.0, 1.0, .2);

uniform sampler2D noise : filter_nearest;

uniform float edge_feather : hint_range(0.0,0.5);

uniform bool local_uv_for_noise = false;
uniform bool enable_glow = true;

uniform vec3 glow_color : source_color = vec3(1,0,0);

uniform sampler2D tint_gradient : filter_nearest;

//lightener🥀....
uniform int tint_type : hint_enum("soft_light","lighten","addition") = 0;

vec4 addition(vec4 base, vec4 blend){
	return vec4((base + blend).rgb,base.a);
}
vec4 lighten(vec4 base, vec4 blend){
	vec4 mixed = max(base, blend);
	mixed.a = base.a;
	return mixed;
}
vec4 soft_light(vec4 base, vec4 blend){
	vec4 limit = step(0.5, blend);
	vec4 pre_alpha = mix(2.0 * base * blend + base * base * (1.0 - 2.0 * blend), sqrt(base) * (2.0 * blend - 1.0) + (2.0 * base) * (1.0 - blend), limit);
	
	return mix(base,pre_alpha,blend.a);
}


void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	
	float orig_a = COLOR.a;
	
	vec2 uv = (UV)/(initial_frame.zw);
	float noise_progress = texture(noise, SCREEN_UV).r;
	if (local_uv_for_noise) {
		noise_progress = texture(noise, UV).r;
	}
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
	
	vec4 effective_tint = texture(tint_gradient,vec2(gradient_progress,0.));
	
	switch (tint_type) {
		case 0:
			COLOR = soft_light(COLOR, effective_tint);
			break;
		case 1:
			COLOR = lighten(COLOR, effective_tint);
			break;
		case 2:
			COLOR = addition(COLOR, effective_tint);
			break;
	}
	
	
	if (glow) {
		COLOR.rgb = max(COLOR.rgb,glow_color);	
	}
	
	COLOR.a = orig_a;
	
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
