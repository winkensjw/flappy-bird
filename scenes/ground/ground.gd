extends Node2D

func _on_area_2d_body_entered(_body: Node2D) -> void:
	Events.emit_signal("player_died")
