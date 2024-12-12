extends Node

@export var damage: float = 0
@export var active: bool = true
var numb: bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if active:
		if not numb: Signals.vitals_damage.emit(damage * delta)
		else: numb = false

func queue_numb():
	numb = true
