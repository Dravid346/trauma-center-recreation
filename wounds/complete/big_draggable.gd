extends "../components/draggable.gd"

func treat():
	Signals.area_treated.emit("cool", position)
	queue_free()
