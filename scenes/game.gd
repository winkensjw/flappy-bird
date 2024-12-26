extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.connect("player_died", Callable(self, "on_player_died"))
	Events.connect("pipes_cleared", Callable(self, "on_pipes_cleared"))
	
func on_player_died() -> void:
	print("Player died")

func on_pipes_cleared() -> void:
	print("Pipes cleared")
