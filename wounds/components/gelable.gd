extends "res://wounds/components/toolable.gd"

func gel_hit(delta: float):
	if enabled:
		health -= delta
		being_hit.emit(health)
		
		if health <= 0:
			treated.emit(self)
