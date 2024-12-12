extends Line2D

var rise: float = 30

func set_label(grade: String = "", ok: bool = true, color: Color = Color("WHITE")):
	$OkLabel.text = "OK" if ok else ""
	$GradeLabel.text = grade
	
	$GradeLabel.add_theme_color_override("font_color", color)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if rise > 0:
		position.y -= 3 * 60 * delta
		rise -= 3 * 60 * delta

func _on_timer_timeout() -> void:
	queue_free()
