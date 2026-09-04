@tool
extends EditorScript

const STEPS := 128

func color_to_oklab(color: Color) -> Vector3:
	var lin: Color = color.srgb_to_linear()
	
	var l: float = 0.4122214708 * lin.r + 0.5363325363 * lin.g + 0.0514459929 * lin.b
	var m: float = 0.2119034982 * lin.r + 0.6806995451 * lin.g + 0.1073969566 * lin.b
	var s: float = 0.0883024619 * lin.r + 0.2817188376 * lin.g + 0.6261798105 * lin.b

	var l_root: float = sign(l) * pow(abs(l), 1.0 / 3.0)
	var m_root: float = sign(m) * pow(abs(m), 1.0 / 3.0)
	var s_root: float = sign(s) * pow(abs(s), 1.0 / 3.0)

	return Vector3(
		0.2104542553 * l_root + 0.7936177850 * m_root - 0.0040720468 * s_root,
		1.9779984951 * l_root - 2.4285922050 * m_root + 0.4505937099 * s_root,
		0.0259040371 * l_root + 0.7827717662 * m_root - 0.8086757660 * s_root
	)

func oklab_to_color(oklab: Vector3, clamp_values: bool = true) -> Color:
	var l_root: float = oklab.x + 0.3963377774 * oklab.y + 0.2158037573 * oklab.z
	var m_root: float = oklab.x - 0.1055613458 * oklab.y - 0.0638541728 * oklab.z
	var s_root: float = oklab.x - 0.0894841775 * oklab.y - 1.2914855480 * oklab.z

	var l: float = l_root * l_root * l_root
	var m: float = m_root * m_root * m_root
	var s: float = s_root * s_root * s_root

	var r: float = +4.0767416621 * l - 3.3077115913 * m + 0.2309699292 * s
	var g: float = -1.2684380046 * l + 2.6097574011 * m - 0.3413193965 * s
	var b: float = -0.0041960863 * l - 0.7034186147 * m + 1.7076286823 * s
	
	# If we are validating gamuts, return raw numbers without clamping them
	if not clamp_values:
		return Color(r, g, b)
		
	var lin_color := Color(r, g, b).clamp()
	return lin_color.linear_to_srgb()


func _run() -> void:
	var colors_srgb: Array = Globals.TILE_POOF_COLOR.values().map(
		func(v): return v[0]
	)
	colors_srgb.append_array(
		Globals.TILE_POOF_COLOR.values().map(
			func(v): return v[1]
		)
	)
	
	colors_srgb.append_array([
		Color(0,0,0, 1.0),
		Color(1,0,0, 1.0),
		Color(0,1,0, 1.0),
		Color(0,0,1, 1.0),
		#bomb
		Color("#a233f7"),
		Color("#251763"),
		Color("#432689"),
		Color("#22222d"),
		
		Color("10a606ff"),
		Color(0.5449, 0.0019, 0.0853, 1.0),
		Color("fd59feff"),
		Color("900280ff"),
		Color(0.0652, 0.4365, 0.002, 1.0),
		Color("035eb7ff")


		
	])
	
	for color in colors_srgb:
		print_rich("[color=#%s]■■■■■■■■%s[/color]"%[color.to_html(),color.to_html()])
	
	var colors_oklab: Array = []
	for color in colors_srgb:
		colors_oklab.append(color_to_oklab(color))
	
	var largest_dist := -1.0  # Initialized below 0 to guarantee updates
	var furthest_color := Vector3(0.5, 0.0, 0.0) # Fallback to standard grey
	
	var get_closest_color_distance = func(to_oklab: Vector3):
		var closest_color_dist := 10000.
		for color in colors_oklab:
			var dist = to_oklab.distance_to(color)
			if dist < closest_color_dist:
				closest_color_dist = dist
		return closest_color_dist
	
	# Core Grid Search Loop
	for L_int in range(0, STEPS):
		var L := lerpf(0.0, 1.0, float(L_int) / (STEPS - 1))
		for A_int in range(0, STEPS):
			var A := lerpf(-0.4, 0.4, float(A_int) / (STEPS - 1))
			for B_int in range(0, STEPS):
				var B := lerpf(-0.4, 0.4, float(B_int) / (STEPS - 1))
				var lab = Vector3(L, A, B)
				
				# 1. Check if this coordinate maps to a real displayable color
				var raw_lin_rgb = oklab_to_color(lab, false)
				if raw_lin_rgb.r < 0.0 or raw_lin_rgb.r > 1.0 or \
				   raw_lin_rgb.g < 0.0 or raw_lin_rgb.g > 1.0 or \
				   raw_lin_rgb.b < 0.0 or raw_lin_rgb.b > 1.0:
					continue # Ignore imaginary colors outside the sRGB cube
				
				# 2. Check how distinct this valid color is from our current list
				var dist = get_closest_color_distance.call(lab)
				if dist > largest_dist:
					largest_dist = dist
					furthest_color = lab
	
	# Print the most visually distinct real color found
	print("Furthest Oklab coordinate: ", furthest_color)
	print("Resulting Color: ", oklab_to_color(furthest_color))
