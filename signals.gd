extends Node

signal vitals_damage(amount: float)
signal vitals_heal(amount: float)
signal max_vitals_damage(amount: int)
signal area_treated(grade: String, position: Vector2)
signal miss(position: Vector2)

func obligation():
	vitals_damage.emit()
	vitals_heal.emit()
	area_treated.emit()
	miss.emit()
	max_vitals_damage.emit()
