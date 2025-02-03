extends CharacterBody2D

@export var jump_force: float = -600.0
@export var air_acceleration: float = 800.0
@export var max_air_speed: float = 2000.0
@export var air_drag: float = 0.02

@onready var flour_meter = $Camera2D/Node2D/Control/FlourMeter
@onready var landing_sound: AudioStreamPlayer2D = $LandingSound

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var was_in_air = false  # Track previous frame's air state

func _ready():
	if flour_meter:
		flour_meter.flour = 100
	else:
		print("ERROR FLOURMETER NOT FOUND")

func _physics_process(delta):
	# Add gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Handle jump
	if is_on_floor() and Input.is_action_just_pressed("ui_accept"):
		var flourmult = flour_meter.flour / 90
		velocity.y = jump_force * flourmult
		flour_meter.flour -= 10
	
	# Get input direction
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if not is_on_floor():
		# Apply air acceleration based on input
		if direction:
			velocity.x += direction * air_acceleration * delta
			velocity.x = clamp(velocity.x, -max_air_speed, max_air_speed)
		else:
			velocity.x = lerp(velocity.x, 0.0, air_drag)
	else:
		velocity.x = 0.0
	
	move_and_slide()

	# Detect landing
	if is_on_floor() and was_in_air:
		landing_sound.play()
	
	# Update was_in_air state
	was_in_air = not is_on_floor()
	
func _input(event):
	if event.is_action_pressed("Exit"):
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
