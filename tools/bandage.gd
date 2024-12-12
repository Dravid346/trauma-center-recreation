extends "res://tools/tool.gd"

var start_point: Vector2
var cur_bandage: Node = null
@export var bandage_scene: PackedScene

func click():
	if cur_bandage != null: release()
	start_point = position
	cur_bandage = bandage_scene.instantiate()
	cur_bandage.adjust_length(start_point, position)
	add_child(cur_bandage)
	
	$BandageSound.play()
	$BandageRollSprite.show()

func move(spot):
	position = spot
	if cur_bandage != null:
		cur_bandage.adjust_length(start_point, position)
		$BandageRollSprite.rotation = Vector2.UP.angle_to(position - start_point)

func release():
	if cur_bandage != null:
		cur_bandage.apply_bandage()
		cur_bandage = null
	
	$BandageSound.stop()
	$BandageRollSprite.rotation = 0
	$BandageRollSprite.hide()
