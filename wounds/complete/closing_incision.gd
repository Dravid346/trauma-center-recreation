extends "res://wounds/components/basic_wound.gd"

var gelled: bool = false

func _on_suturable_being_hit(node: Area2D) -> void:
	var _score = -node.health #sutures deal damage equal to score, suturable has starting health = 0
	Signals.area_treated.emit("good", position)
	$Suturable.monitorable = false
	
	$AnimatedSprite2D.animation = "sutured"
	$Gelable.monitorable = true
	$Bandagable.monitorable = true


func _on_gelable_treated(_position) -> void:
	gelled = true
	Signals.area_treated.emit("ok", position)
	$Gelable.monitorable = false
	$Gelable.enabled = false


func _on_bandagable_being_hit(_node) -> void:
	var grade = "cool" if gelled else "bad"
	Signals.area_treated.emit(grade, position)
	treated.emit(self)
	
	$Bandagable.monitorable = false
	$Gelable.monitorable = false
	$Gelable.enabled = false
