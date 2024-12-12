extends "res://wounds/components/toolable.gd"

func bandage_applied(bandage: Area2D) -> bool:
	if not bandage in $PointA.get_overlapping_areas(): return false
	if not bandage in $PointB.get_overlapping_areas(): return false
	
	bandage.treated_wound = true
	being_hit.emit(self)
	
	return true
