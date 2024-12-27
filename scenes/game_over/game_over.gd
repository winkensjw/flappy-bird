extends Control

@onready var scoreBox = %ScoreHBox
@onready var bestBox = %BestHBox

func prepare_final_score() -> void:
	Globals.saveBest()
	remove_all_children()
	var scoreText = str(Globals.score)
	for character in scoreText:
		scoreBox.add_child(createTextureRect(character))
	var bestText = str(Globals.best)
	for character in bestText:
		bestBox.add_child(createTextureRect(character))

func createTextureRect(imageName : String) -> TextureRect:
	var rect = TextureRect.new()
	var image = load("res://resources/"+imageName+".png")
	rect.set_texture(image)
	return rect

func remove_all_children() -> void:
	for child in scoreBox.get_children():
		scoreBox.remove_child(child)
	for child in bestBox.get_children():
		bestBox.remove_child(child)


func _on_button_pressed() -> void:
	Events.emit_signal("game_end")
