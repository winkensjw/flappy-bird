extends Control

@onready var hbox = $CenterContainer/HBoxContainer
@onready var score = 0

func _ready() -> void:
	Events.connect("pipes_cleared", Callable(self, "_on_pipes_cleared"))
	update_score(0)

func _on_pipes_cleared() -> void:
	update_score(1)
	
func update_score(increment:int) -> void:
	score += increment
	update_score_ui()

func update_score_ui() -> void:
	remove_all_children()
	var scoreText = str(score)
	for character in scoreText:
		hbox.add_child(createTextureRect(character))

func createTextureRect(imageName : String) -> TextureRect:
	var rect = TextureRect.new()
	var image = load("res://resources/"+imageName+".png")
	rect.set_texture(image)
	return rect

func remove_all_children() -> void:
	for child in hbox.get_children():
		hbox.remove_child(child)
