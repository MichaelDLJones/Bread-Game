extends Area2D
@onready var timer: Timer = $Timer
@onready var mgh: AudioStreamPlayer2D = $Mgh

var death_sounds: Array = [
	preload("res://Assets/sounds/voice-message.mp3"),
	preload("res://Assets/sounds/Record (online-voice-recorder.com).mp3")
]

func _on_body_entered(body):
	print("You died!")
	mgh.stream = death_sounds[randi() % death_sounds.size()]
	mgh.play()
	timer.start()


func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()
