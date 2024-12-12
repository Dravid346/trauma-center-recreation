extends Sprite2D

signal treated
signal gel_struck

var gelled = false

func scalpel_hit(_health):
	if not gelled:
		Signals.vitals_damage.emit(1)
	treated.emit()
	queue_free()

func gel_hit(_health = 0):
	gelled = true
	modulate.b = 1
	modulate.r = 0
	$Gelable.enabled = false
	$Gelable.queue_free()
	gel_struck.emit()
