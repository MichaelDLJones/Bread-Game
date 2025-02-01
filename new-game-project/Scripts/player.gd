extends CharacterBody2D

@export var move_speed: float = 500.0  # Increased base speed
@export var jump_velocity: float = -400.0
@export var roll_speed: float = 15.0
@export var momentum_factor: float = 0.95  # Slightly higher momentum preservation
@export var rotation_influence: float = 1.2
@export var base_traction: float = 250.0  # New value for minimum movement speed

@onready var sprite: Sprite2D = $Sprite2D
var angular_velocity: float = 0.0

func _physics_process(delta: float) -> void:
	# Apply gravity with rotational influence
	if not is_on_floor():
		var gravity = ProjectSettings.get("physics/2d/default_gravity")
		velocity.y += gravity * delta
		velocity.x += sin(rotation) * gravity * delta * 0.5
	
	# Handle jump - harder to control when rotated
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity * cos(rotation)
		angular_velocity += velocity.x * 0.01
	
	# Handle movement
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		# Base movement that ensures some progress
		var base_movement = direction * base_traction * delta
		
		# Chaotic movement influenced by rotation
		var effective_speed = move_speed * (1.0 + sin(rotation) * rotation_influence)
		var chaotic_movement = direction * effective_speed * delta
		
		# Combine both movements, ensuring we always have some forward progress
		velocity.x += base_movement + chaotic_movement
		angular_velocity += direction * roll_speed * delta
		
		# Add some unpredictability to rotation
		if is_on_floor():
			angular_velocity += direction * sin(rotation) * roll_speed * 0.5 * delta
	
	# Apply momentum with minimum movement preservation
	velocity.x *= momentum_factor
	angular_velocity *= momentum_factor
	
	# Higher speed cap for better progression
	velocity.x = clamp(velocity.x, -move_speed * 3, move_speed * 3)
	angular_velocity = clamp(angular_velocity, -PI * 2, PI * 2)
	
	# Apply rotation
	rotation += angular_velocity * delta
	
	move_and_slide()
