extends Area2D

var overlapping = false
@export var passive_damage: float = 0.3

func _mouse_enter() -> void:
	overlapping = true

func _mouse_exit() -> void:
	overlapping = false
