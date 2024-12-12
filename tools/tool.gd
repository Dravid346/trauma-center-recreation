extends Area2D

signal exhausted

var max_durability = 100
@onready var cur_durability = max_durability
var cooldown: bool = false

func click():
	pass #print("Undefined tool click")

func release():
	pass
	#print("Undefinied tool release")

func equip():
	pass

func unequip():
	release()

func move(spot: Vector2):
	position = spot

func use_durability(amount: float):
	cur_durability -= amount
	if cur_durability <= 0:
		exhausted.emit()
		#print("tool has been exhausted")

func reset():
	release()
	var targets = get_children()
	for i in targets:
		if i.is_in_group("spawnable"):
			i.queue_free()
