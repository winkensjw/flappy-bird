extends Node2D

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if (event is InputEventMouseButton && event.pressed):
		Events.emit_signal("start_game")
