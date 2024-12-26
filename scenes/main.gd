extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.connect("player_died", Callable(self, "on_player_died"))
	
func on_player_died() -> void:
	print("Player died")
