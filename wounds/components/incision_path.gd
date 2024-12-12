extends "res://wounds/components/scalpel_path.gd"

signal path_gelled

var dots_ungelled: int = 0

func add_dot(progress: float):
	$PathFollow2D.progress_ratio = progress
	
	var dot = dot_scene.instantiate()
	dot.position = $PathFollow2D.position
	dot.connect("treated", dot_cut)
	dot.connect("gel_struck", dot_gelled)
	add_child(dot)
	
	$Line2D.add_point($PathFollow2D.position)
	
	dots_remaining += 1
	dots_ungelled += 1

func dot_gelled():
	dots_ungelled -= 1
	if dots_ungelled <= 0:
		path_gelled.emit()
		$Line2D.modulate.r = 0
		$Line2D.modulate.b = 1
