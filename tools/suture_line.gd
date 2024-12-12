extends Line2D

var fading: bool = false
var queue_fading: bool = false
var fading_countdown: int = 3
var queue_thread: bool = false
var thread_point: Vector2 = Vector2.ZERO
var targets: Array[Area2D] = []

func _ready():
	$Area2D/CollisionShape2D.shape.a = Vector2.ZERO
	$Area2D/CollisionShape2D.shape.b = Vector2.ZERO

func thread(spot):
	thread_point = spot
	queue_thread = true

func finish():
	fading_countdown = 2

func _physics_process(_delta) -> void:
	for i in $Area2D.get_overlapping_areas():
		if i.is_in_group("suturable") and i not in targets:
			#print(i)
			targets.append(i)
	
	if fading_countdown == 2: fading_countdown = 1
	elif fading_countdown == 1:
		$Area2D/CollisionShape2D.disabled = true
		fading = true
		queue_fading = false
		suture_wound()
		fading_countdown = 0
		return
	
	if queue_thread and not fading:
		$Area2D/CollisionShape2D.shape.a = points[-1]
		add_point(thread_point)
		$Area2D/CollisionShape2D.shape.b = thread_point
		queue_thread = false

func _process(delta: float):
	if fading:
		modulate.a -= delta*2
		if modulate.a <= 0:
			queue_free()

func suture_wound():
	var top_student: Area2D = null
	var highest_score: float = 0
	for i in targets:
		var grade = grade_suture(i.get_line())
		if grade > highest_score and grade >= i.required_score:
			top_student = i
			highest_score = grade
	
	if top_student != null: top_student.tool_hit(highest_score)

func grade_suture(wound: Array[Vector2]):
	var hits: Array[Vector2] = []
	for i in range(points.size() - 1):
		var result = Geometry2D.segment_intersects_segment(points[i], points[i+1], wound[0], wound[1])
		if result != null: hits.append(result)
	
	return hits.size()
