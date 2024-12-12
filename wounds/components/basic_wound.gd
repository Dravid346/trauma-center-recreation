extends Node2D

signal treated(node: Node)

func treat(grade: String = "ok"):
	Signals.area_treated.emit(grade, position)
	treated.emit()
	queue_free()
