extends "res://wounds/components/toolable.gd"

@export var required_score: float = 0

func get_line() -> Array[Vector2]:
	return [$MarkerA.global_position, $MarkerB.global_position]
