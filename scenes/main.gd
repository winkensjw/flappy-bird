extends Node2D

const game = preload("res://scenes/game.tscn")
const main_menu = preload("res://scenes/main_menu/main_menu.tscn")
var main_menu_instance
var game_instance

func _ready() -> void:
	Events.connect("start_game", Callable(self, "on_game_started"))
	Events.connect("game_end", Callable(self, "on_game_ended"))
	boot_game()

func boot_game() -> void:
	main_menu_instance = main_menu.instantiate()
	self.add_child(main_menu_instance)
	
func on_game_started() -> void:
	main_menu_instance.queue_free()
	game_instance = game.instantiate()
	self.add_child(game_instance)

func on_game_ended() -> void:
	game_instance.queue_free()
	boot_game()
	
