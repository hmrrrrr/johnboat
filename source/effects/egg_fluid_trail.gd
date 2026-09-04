extends Line2D
class_name EggFluidTrail

var eggshell_a: EggshellEffect
var eggshell_b: EggshellEffect

var sillyness := 10. #idk what to call it
var offset := Vector2.ZERO

func _physics_process(delta: float) -> void:
	if eggshell_a and eggshell_b:
		var curve := Curve2D.new()
		
		curve.add_point(to_local(eggshell_a.global_position + offset))
		curve.add_point(Vector2.ZERO,Vector2(-sillyness,-sillyness/3.),Vector2(sillyness,-sillyness/3.))
		curve.add_point(to_local(eggshell_b.global_position + offset))
		
		sillyness += delta*60.*1.5
		curve.bake_interval = 16
		points = curve.get_baked_points()
		
	else:
		queue_free()
