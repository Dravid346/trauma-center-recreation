extends Control

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		$LetsBegin.stop()
		$LetsBegin.finished.emit()

func begin():
	$Panel/Label.text = "BEGIN OPERATION"
	$Panel.show()
	$LetsBegin.play()
	await $LetsBegin.finished
	$Panel.hide()
	return

func complete():
	$Panel/Label.text = "OPERATION SUCCESSFUL"
	$Panel.show()
	$GradeLetterAndCompletion.play()
	await get_tree().create_timer(0.5).timeout
	#await $GradeLetterAndCompletion.finished
	$OperationComplete.play()
	await $OperationComplete.finished
	return

func failed():
	$Panel/Label.text = "OPERATION FAILED"
	$Panel.show()
	$OperationFailed.play()
	await $OperationFailed.finished
	await get_tree().create_timer(1).timeout
	return
