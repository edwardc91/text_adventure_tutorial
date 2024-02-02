class_name Exit
extends Resource

var area1: WorldArea = null
var is_locked_area1: bool = false

var area2: WorldArea = null
var is_locked_area2: bool = false


func get_direction_exit_data(area: WorldArea) -> Array:
	if area == self.area1:
		return [self.area2, self.is_locked_area2]
	if area == self.area2:
		return [self.area1, self.is_locked_area1]

	return [null, null]