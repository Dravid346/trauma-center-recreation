extends Area2D

signal evaporate(puddle: Area2D)

var juice: float = 0
var max_juice: float = 0
var growth: float = 0.1
var used: bool = false

func _ready():
	fade(0)

func _process(delta: float) -> void:
	var targets = get_overlapping_areas()
	for i in targets:
		if i.is_in_group("gelable") and i.gel_type != "disabled":
			i.gel_hit(delta)
			if i.gel_type == "consume":
				used = true
	
	fade(delta)

func fade(delta: float):
	var multiplier = 1 if not used else 5
	juice -= delta * multiplier
	modulate.a = (juice/max_juice) / 2
	if juice <= 0:
		evaporate.emit(self)
	
	scale += Vector2(growth * delta * multiplier, growth * delta * multiplier)

func set_juice(new_juice: float):
	juice = new_juice
	max_juice = new_juice
