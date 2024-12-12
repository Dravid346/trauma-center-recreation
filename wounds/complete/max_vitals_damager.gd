extends "../components/basic_wound.gd"

func _on_timer_timeout() -> void:
	Signals.max_vitals_damage.emit(5)
