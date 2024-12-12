extends Node

@export var label_scene: PackedScene

var cools = 0
var goods = 0
var oks = 0
var bads = 0
var misses = 0

func _ready():
	Signals.connect("area_treated", treated)
	Signals.connect("miss", miss)

func treated(grade: String = "ok", position: Vector2 = Vector2.ZERO):
	match grade:
		"cool":
			$Cool.play()
			cools += 1
		"good":
			$Ok.play()
			goods += 1
		"ok":
			$Ok.play()
			oks += 1
		"bad":
			$Ok.play()
			bads += 1
	
	#create label
	var label = label_scene.instantiate()
	label.position = position
	if grade != "ok": label.set_label(grade.to_upper())
	add_child(label)

func miss(position: Vector2 = Vector2.ZERO):
	$Miss.play()
	misses += 1
	
	var label = label_scene.instantiate()
	label.position = position
	label.set_label("MISS", false, Color(1.0, 0.5, 0.5))
	add_child(label)
