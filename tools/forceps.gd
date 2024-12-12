extends "tool.gd"

var grabbed_object: Area2D = null

func click():
	for i in get_overlapping_areas():
		if "grab_type" in i and i.grab_type != "disabled":
			var success = i.grab(position)
			if success:
				grabbed_object = i
				$ForcepsSound.play()
				$Sprite2D.show()
				i.connect("dropped", _on_object_dropped)
				if i.grab_type == "tray":
					$ExtractionTray.show()
			return

func release():
	if grabbed_object != null:
		grabbed_object.drop(is_over_tray())

func _on_object_dropped():
	grabbed_object.disconnect("dropped", _on_object_dropped)
	$Sprite2D.hide()
	$ExtractionTray.hide()
	grabbed_object = null

func is_over_tray():
	for i in get_overlapping_areas():
		if i.is_in_group("tray"):
			return true
	return false
