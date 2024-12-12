extends "res://wounds/components/basic_wound.gd"

func popped(_position):
	$Laserable.enabled = false
	Signals.area_treated.emit("ok", position)
	$AnimatedSprite2D.animation = "popped"
	$Gelable.enabled = true

func gelled(_health):
	treat("ok")
