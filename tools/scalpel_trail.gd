extends Line2D

var starting_lifespan: float = 35.0/60.0
var lifespan: float = 35.0/60.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	lifespan -= delta
	modulate.a = lifespan/starting_lifespan
	
	if lifespan <= 0:
		queue_free()
