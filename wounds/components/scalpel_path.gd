extends Path2D

signal treated

@export var dot_count: int = 0
@export var density: float = 2.0
@export var use_density: bool = true
@export var dot_scene: PackedScene
var density_divider: int = 100
var dots_remaining: int = 0
@export var autoset: bool = true

func _ready():
	if autoset:
		set_dots()

func set_dots():
	var num_dots: int = dot_count
	if use_density:
		num_dots = round(curve.get_baked_length() * density / density_divider)
	
	for i in range(num_dots):
		var progress = i * 1.0/num_dots
		add_dot(progress)
	
	add_dot(1) #a dot at the end of the line, since that gets skipped by the loop

func add_dot(progress: float):
	$PathFollow2D.progress_ratio = progress
	
	var dot = dot_scene.instantiate()
	dot.position = $PathFollow2D.position
	dot.connect("treated", dot_cut)
	dot.modulate.r = 0
	add_child(dot)
	
	$Line2D.add_point($PathFollow2D.position)
	
	dots_remaining += 1

func dot_cut():
	dots_remaining -= 1
	if dots_remaining <= 0:
		treat()

func treat():
	treated.emit()
	queue_free()
