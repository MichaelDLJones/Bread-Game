extends Area2D
 
@onready var oven_door = $AnimatedSprite2D
@onready var win_text = $Label
@onready var Timer2 = $Timer2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered)
	if (win_text):
		win_text.visible = false
	else:
		push_error("win text label not assigned!")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body):
	if (body.name == "CharacterBody2D"):
		if (oven_door):
			#print("oven")
			oven_door.play("Oven_Door")
		if (win_text):
			win_text.visible = true
		Timer2.start()
			
func _on_timer_2_timeout() -> void:
	get_tree().reload_current_scene()
