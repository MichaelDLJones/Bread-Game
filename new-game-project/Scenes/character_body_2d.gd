extends CharacterBody2D

@export var jump_force: float = -600.0
@export var air_acceleration: float = 1800.0
@export var max_air_speed: float = 1000.0
@export var air_drag: float = 0.02

@onready var flour_meter = $Camera2D/Node2D/Control/FlourMeter

var flourmult = 1.0

func _ready():
	if flour_meter:
		flour_meter.flour = 100
	else:
		print("ERROR: FLOURMETER NOT FOUND")

# Get the gravity from the project settings to be synced with RigidBody nodes
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Add gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Handle jump
	if is_on_floor() and Input.is_action_just_pressed("ui_accept"):
		flourmult = flour_meter.flour / 100
		velocity.y = jump_force * flourmult
		flour_meter.flour -= 10
	
	# Get input direction
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if not is_on_floor():
		# Apply air acceleration based on input
		if direction:
			velocity.x += direction * air_acceleration * delta
			# Clamp horizontal velocity to max speed
			velocity.x = clamp(velocity.x, -max_air_speed, max_air_speed)
		else:
			# Apply air drag when no input is pressed
			velocity.x = lerp(velocity.x, 0.0, air_drag)
	else:
		# Reset horizontal velocity when on ground
		velocity.x = 0.0
	
	move_and_slide()
