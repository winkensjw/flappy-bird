extends Node2D

func _on_upper_pipe_body_entered(body: Node2D) -> void:
	print("Upper Pipe Entered")


func _on_lower_pipe_2_body_entered(body: Node2D) -> void:
	print("Lower Pipe Entered")
