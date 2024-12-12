extends "res://wounds/components/draggable.gd"

func excised():
	Signals.area_treated.emit("ok", position)
	$Sprite2D.modulate.v *= 0.5
	grab_type = "tray"
