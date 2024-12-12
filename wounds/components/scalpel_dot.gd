extends Sprite2D

signal treated

func scalpel_touch(_health):
	treated.emit()
	queue_free()
