extends Area2D

signal dropped
signal treated

var dragging = false
@onready var reset_position = position
@onready var original_z = [z_index, z_as_relative]
@export var drop_damage = 5
@export var grab_type: String = "tray"

func _input(event: InputEvent):
	if dragging and event is InputEventMouseMotion:
		move(event.position)

func grab(spot = null):
	dragging = true
	z_index = 2
	z_as_relative = false
	if spot != null:
		move(spot)
	return true

func drop(over_tray: bool = false):
	dragging = false
	z_index = original_z[0]
	z_as_relative = original_z[1]
	dropped.emit()
	
	if over_tray:
		treat()
	else:
		blunder()

func move(spot: Vector2):
	position = spot

func treat():
	#wound treated
	treated.emit()
	Signals.area_treated.emit("ok", position)
	queue_free()

func blunder():
	#penalize and reset position
	Signals.vitals_damage.emit(drop_damage)
	Signals.miss.emit(position)
	position = reset_position
