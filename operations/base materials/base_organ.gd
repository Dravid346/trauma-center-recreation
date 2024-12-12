extends Node2D

signal stage_complete

var remaining_wounds: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in get_children():
		connect_wound(i)

func spawn_wound(wound: PackedScene):
	var new_wound = wound.instantiate()
	add_child(new_wound)
	connect_wound(new_wound)

func wound_treated(_node = null):
	remaining_wounds -= 1
	if remaining_wounds == 0:
		stage_complete.emit()

func connect_wound(wound):
	for i in wound.get_signal_list():
		if i.name == "treated":
			wound.connect("treated", wound_treated)
			remaining_wounds += 1
			return
