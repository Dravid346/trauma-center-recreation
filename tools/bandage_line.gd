extends Area2D

const BASE_HEIGHT = 320
var treated_wound = false

func adjust_length(point1: Vector2, point2: Vector2):
	position = (point1 + point2) / 2
	scale.y = (point1.distance_to(point2))/BASE_HEIGHT
	rotation = Vector2.UP.angle_to(point2 - point1)

func apply_bandage():
	var targets = get_overlapping_areas()
	for i in targets:
		if i.is_in_group("bandagable"):
			if i.bandage_applied(self): treated_wound = true
	
	if not treated_wound:
		Signals.miss.emit(position)
		Signals.vitals_damage.emit(5)
		queue_free()
	else:
		$CollisionShape2D.disabled = true
