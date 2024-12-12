extends "./tool.gd"

var active: bool = false

func click():
	active = true
	$Line2D.show()
	$Line2D.set_point_position(1, position)
	$LaserSound.play()

func release():
	active = false
	$Line2D.hide()
	$LaserSound.stop()

func move(spot: Vector2):
	position = spot
	$Line2D.set_point_position(1, position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if active:
		var targets = get_overlapping_areas()
		for i in targets:
			if i.is_in_group("laserable"):
				i.laser_hit(delta)
		
		use_durability(20 * delta)
