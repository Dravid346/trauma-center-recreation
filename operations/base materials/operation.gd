extends Node

signal operation_complete

@export var stages: Array[PackedScene]
var stage_index: int = 0
var cur_stage: Node = null

func _ready():
	advance_stage()
	get_tree().paused = true
	await $StartEndStuff.begin()
	get_tree().paused = false
	$MusicManager/Operation1.play()

func advance_stage():
	if stage_index < stages.size():
		if cur_stage != null:
			remove_child(cur_stage)
			cur_stage.queue_free()
		
		cur_stage = stages[stage_index].instantiate()
		add_child(cur_stage)
		cur_stage.connect("stage_complete", advance_stage)
		stage_index += 1
	
		$Toolbox.reset_tools()
	else:
		complete()

func complete():
	get_tree().paused = true
	await $StartEndStuff.complete()
	operation_complete.emit()
	get_tree().quit()
	#then do whatever happens after an operation is done

func _on_vitals_operation_failed() -> void:
	get_tree().paused = true
	await $StartEndStuff.failed()
	get_tree().quit()
	#then do whatever happens after an operation is failed
