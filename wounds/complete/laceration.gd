extends "res://wounds/components/basic_wound.gd"

func _on_suturable_being_hit(node: Area2D) -> void:
	var _score = -node.health #sutures deal damage equal to score, suturable has starting health = 0
	treat("good")
