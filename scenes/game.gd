extends Node2D


const pipes = preload("res://scenes/pipes/pipes.tscn")
@onready var pipetimer = $PipeTimer
@onready var bird = $FlappyBird

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.connect("player_died", Callable(self, "on_player_died"))
	Events.connect("pipes_cleared", Callable(self, "on_pipes_cleared"))
	spawn_pipe()
	
	
func on_player_died() -> void:
	print("Player died")

func on_pipes_cleared() -> void:
	print("Pipes cleared")


func _on_pipe_timer_timeout() -> void:
	spawn_pipe() 
	
func spawn_pipe() -> void:
	var pipes_instance = pipes.instantiate()
	# pipe y position between 75 and 220
	pipes_instance.position.x = bird.position.x + 300
	pipes_instance.position.y = randi() % 146 + 75
	self.add_child(pipes_instance)
	# remove pipe after 5 secondes (its off screen by now)
	# TODO replace this by its own method that considers the game state, i.e. don't remove pipes after the game ended
	var pipe_kill_timer = Timer.new()
	pipe_kill_timer.wait_time = 5.0
	pipe_kill_timer.one_shot = true
	pipe_kill_timer.autostart = true
	pipe_kill_timer.connect("timeout", func(): pipes_instance.queue_free())
	pipe_kill_timer.connect("timeout", func(): pipe_kill_timer.queue_free())
	self.add_child(pipe_kill_timer)
