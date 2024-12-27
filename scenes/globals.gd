extends Node

var running = false
var score = 0
var best = 0

func _ready() -> void:
	loadBest()

func saveBest() -> void:
	if score <= best:
		return;
	
	best = score
	
	var save_dict = {
		"best": best
	}
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var json_string = JSON.stringify(save_dict)
	save_file.store_line(json_string)
	
func loadBest() -> void:
	if not FileAccess.file_exists("user://savegame.save"):
		return
	
	var save_file = FileAccess.open("user://savegame.save", FileAccess.READ)
	var json_string = save_file.get_line()
	var json = JSON.new()
	var parse_result = json.parse(json_string)
	if not parse_result == OK:
		print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
		return;
	var node_data = json.data
	var localBest = node_data["best"]
	best = localBest
