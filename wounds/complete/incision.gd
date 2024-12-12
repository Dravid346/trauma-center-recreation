extends "res://wounds/components/basic_wound.gd"

var gelled: bool = false

func path_gelled():
	Signals.area_treated.emit("ok", position)
	gelled = true

func incision_made():
	var grade = "cool" if gelled else "bad"
	Signals.area_treated.emit(grade, position)
	$Sprite2D.show()
	
	treated.emit()
