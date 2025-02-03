extends Control

func _ready():
	# Connect buttons to functions
	$VBoxContainer/StartButton.connect("pressed", _on_start_button_pressed)
	$VBoxContainer/QuitButton.connect("pressed", _on_quit_button_pressed)

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/game.tscn")  # Change to your game scene

func _on_quit_button_pressed():
	get_tree().quit()  # Exits the game
