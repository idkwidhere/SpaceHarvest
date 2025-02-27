extends Control

@onready var options: Panel = $Options

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_start_game_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Space/space.tscn")


func _on_options_pressed() -> void:
	options.show()


func _on_quit_pressed() -> void:
	get_tree().quit()


# options:


func _on_back_pressed() -> void:
	options.hide()
