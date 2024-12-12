extends Area2D

signal being_hit(node: Area2D)
signal treated(node: Area2D)

@export var health: float = 0.1
@export var enabled: bool = true
@export var gel_type: String = "consume"

func tool_hit(delta: float):
	if enabled:
		health -= delta
		being_hit.emit(self)
		
		if health <= 0:
			treated.emit(self)
