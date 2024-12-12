extends Node

signal operation_failed

@export var starting_vitals = 90.0
@export var starting_max_vitals = 99.0
@onready var cur_vitals = starting_vitals
@onready var max_vitals = starting_max_vitals

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Signals.connect("vitals_damage", damage)
	Signals.connect("max_vitals_damage", max_vitals_damage)
	Signals.connect("vitals_heal", heal)
	set_max_vitals(starting_max_vitals)
	set_vitals_display()

func damage(amount):
	cur_vitals -= amount
	if cur_vitals < 0:
		operation_failed.emit()
	
	set_vitals_display()

func heal(amount):
	cur_vitals += amount
	if cur_vitals > max_vitals:
		cur_vitals = max_vitals
	
	set_vitals_display()
	
func set_vitals_display():
	var display_vitals = round(cur_vitals)
	if display_vitals < 0:
		display_vitals = 0
	$VitalsLabel.text = str(display_vitals)
	$HealthBar.value = cur_vitals

func set_max_vitals(amount):
	max_vitals = amount
	if cur_vitals > max_vitals:
		cur_vitals = max_vitals
	$HealthBar.max_value = max_vitals
	$HealthBar.size.x = 496 * (max_vitals/99)
	
	set_vitals_display()

func max_vitals_damage(amount):
	set_max_vitals(max_vitals - amount)
