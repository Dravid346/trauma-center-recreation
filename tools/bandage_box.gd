extends Node

signal equip_bandage(bandage_node: Node)

func _process(_delta: float) -> void:
	if get_tree().get_nodes_in_group("bandagable").size() != 0:
		$BandageButton.show()
	else:
		$BandageButton.hide()
	
func _on_bandage_button_button_down() -> void:
	equip_bandage.emit($Bandage)
