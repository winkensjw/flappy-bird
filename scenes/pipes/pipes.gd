extends Node2D

func _on_upper_pipe_body_entered(body: Node2D) -> void:
	Events.emit_signal("player_died")


func _on_lower_pipe_2_body_entered(body: Node2D) -> void:
	Events.emit_signal("player_died")


func _on_clearance_body_entered(body: Node2D) -> void:
	Events.emit_signal("pipes_cleared")
