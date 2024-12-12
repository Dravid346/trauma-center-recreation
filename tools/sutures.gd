extends "res://tools/tool.gd"

@export var line_scene: PackedScene
var cur_line: Line2D = null
@onready var last_position: Vector2 = position
var last_direction: Vector2 = Vector2.ZERO
const MAX_ANGLE = PI/4

func click():
	if cur_line != null: release()
	$SutureStartSound.play()
	last_direction = Vector2.ZERO
	last_position = position
	cur_line = line_scene.instantiate()
	add_child(cur_line)
	cur_line.add_point(position)

func release():
	if cur_line != null:
		add_line_point(position)
		cur_line.finish()
		cur_line = null

func move(spot):
	position = spot
	var direction = position - last_position
	
	if cur_line != null:
		var thread_direction = position - cur_line.points[-1]
		var angle_change = abs(direction.angle_to(thread_direction))
		if angle_change > MAX_ANGLE:
			add_line_point(last_position)
	
	last_position = position
	

func add_line_point(spot):
	if cur_line != null:
		cur_line.thread(spot)
		
		if $SutureLineSound.playing: $SutureLineSound2.play()
		else: $SutureLineSound.play()
