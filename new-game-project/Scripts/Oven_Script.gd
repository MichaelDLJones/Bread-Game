extends Area2D
 
@onready var oven_door = $AnimatedSprite2D
@onready var win_text = $Label
@onready var Timer2 = $Timer2
@onready var door_close_sfx = $Door_close
var win: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered)
	if (win_text):
		win_text.visible = false
	else:
		push_error("win text label not assigned!")
	win = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (!oven_door.is_playing() && win):
		if (win_text):
			win_text.visible = true

func _on_body_entered(body):
	if (body.name == "CharacterBody2D"):
		win = true
		if (oven_door):
			oven_door.play("Oven_Door")
		if (door_close_sfx):
			door_close_sfx.play()
			
		Timer2.start()
			
func _on_timer_2_timeout() -> void:
	get_tree().reload_current_scene()
