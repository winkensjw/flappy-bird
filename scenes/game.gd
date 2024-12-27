extends Node2D


const pipes = preload("res://scenes/pipes/pipes.tscn")
const game_over = preload("res://scenes/game_over/game_over.tscn")
@onready var pipetimer = $PipeTimer
@onready var bird = $FlappyBird
@onready var ui_layer = %UiLayer
@onready var counter = %Counter

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.connect("player_died", Callable(self, "on_player_died"))
	Globals.running = true
	Globals.score = 0
	spawn_pipe()
	
	
func on_player_died() -> void:
	Globals.running = false
	counter.queue_free()
	var game_over_instance = game_over.instantiate()
	ui_layer.add_child(game_over_instance)


func _on_pipe_timer_timeout() -> void:
	spawn_pipe() 
	
func spawn_pipe() -> void:
	if not Globals.running:
		return
	
	var pipes_instance = pipes.instantiate()
	# pipe y position between 75 and 220
	pipes_instance.position.x = bird.position.x + 300
	pipes_instance.position.y = randi() % 146 + 75
	self.add_child(pipes_instance)
	# remove pipe after 5 secondes (its off screen by now)
	var pipe_kill_timer = Timer.new()
	pipe_kill_timer.wait_time = 5.0
	pipe_kill_timer.one_shot = true
	pipe_kill_timer.autostart = true
	
	var clean_up_pipe = func():
		if Globals.running:
			pipes_instance.queue_free()
		pipe_kill_timer.queue_free()
		
	pipe_kill_timer.connect("timeout", clean_up_pipe)
	self.add_child(pipe_kill_timer)
