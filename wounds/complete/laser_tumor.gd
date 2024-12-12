extends "res://wounds/components/draggable.gd"

var been_lasered: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	grab_type = "trap"

func grab(spot = null):
	if been_lasered:
		return super(spot)
	else:
		blunder()
		return false

func laser_me_daddy(_position):
	Signals.area_treated.emit("ok", position)
	been_lasered = true
	$LaserTumorSprite.animation = "lasered"
	grab_type = "tray"
	$Laserable.enabled = false
	$GradeTimer.start()

func treat():
	var score = $GradeTimer.time_left
	var grade = "bad"
	if score >= 1:
		grade = "cool"
	elif score >= 0.5:
		grade = "good"
	
	Signals.area_treated.emit(grade, position)
	treated.emit()
	
	queue_free()
