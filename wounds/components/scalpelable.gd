extends Area2D

signal being_scalpeled(cur_health: float)
signal treated(position: Vector2)

@export var health: float = 0.1
@export var enabled: bool = true

func scalpel_hit(delta: float):
	if enabled:
		health -= delta
		being_scalpeled.emit(health)
		
		if health <= 0:
			treated.emit()
