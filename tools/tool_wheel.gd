extends Node2D

var slots: Array[Sprite2D]
var index: int = 8

func _ready():
	slots = [$ScHex, $FoHex, $GeHex, $SyHex, $SuHex, $DrHex, $LaHex, $UlHex]
	pass#create slots array

func set_equipped(new_index: int):
	if new_index > slots.size(): print("Invalid tool wheel index: " + str(new_index))
	if index != new_index:
		unequip()
		
		index = new_index
		var slot = slots[index]
		slot.modulate.v = 1
		slot.scale = Vector2(1.5, 1.5)
		slot.z_index = 1

func unequip():
	if index < slots.size():
		var slot: Sprite2D = slots[index]
		slot.modulate.v = 0.5
		slot.scale = Vector2(1, 1)
		slot.z_index = 0
		index = slots.size()
