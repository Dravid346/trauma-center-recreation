extends Area2D

signal being_lasered(cur_health: float)
signal treated(position: Vector2)

@export var health: float = 0.1
@export var enabled: bool = true

func laser_hit(delta: float):
	if enabled:
		health -= delta
		being_lasered.emit(health)
		
		if health <= 0:
			treated.emit(position)
