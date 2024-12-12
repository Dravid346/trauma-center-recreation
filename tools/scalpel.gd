extends "res://tools/tool.gd"

var active: bool = false
var queue_deactivate: bool = false
var queue_moved: bool = false
@export var trail_scene: PackedScene
@onready var last_position: Vector2 = position

func click():
	active = true
	$ScalpelDot.show()
	$ScalpelSound.play()

func release():
	queue_deactivate = true
	$ScalpelDot.hide()
	$ScalpelSound.stop()

func move(spot: Vector2):
	queue_moved = true
	position = spot

func _physics_process(delta: float):
	if active:
		var targets = get_overlapping_areas()
		for i in targets:
			if i.is_in_group("scalpelable"): i.scalpel_hit(delta)
		
		use_durability(20 * delta)
		Signals.vitals_damage.emit(2 * delta)
		
	if queue_deactivate:
		active = false
		queue_deactivate = false
	
	if queue_moved:
		$LineCollision.shape.a = last_position - position
		if active: add_trail()
		queue_moved = false
	
	last_position = position

func add_trail():
	var new_trail = trail_scene.instantiate()
	new_trail.add_point(last_position)
	new_trail.add_point(position)
	add_child(new_trail)
