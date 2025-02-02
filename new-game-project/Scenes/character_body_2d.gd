extends CharacterBody2D

@export var move_speed: float = 300.0
@export var jump_velocity: float = -400.0
@export var roll_speed: float = 15.0  # Increased for more chaos
@export var momentum_factor: float = 0.92  # Preserves movement
@export var rotation_influence: float = 1.2  # Movement affected by rotation

var angular_velocity: float = 0.0

func _physics_process(delta: float) -> void:
	# Apply gravity with rotational influence
	if not is_on_floor():
		var gravity = ProjectSettings.get("physics/2d/default_gravity")
		velocity.y += gravity * delta
		# Rotation affects falling
		velocity.x += sin(rotation) * gravity * delta * 0.5
	
	# Handle jump - harder to control when rotated
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity * cos(rotation)  # Jump affected by rotation
		angular_velocity += velocity.x * 0.01  # Add spin when jumping
	
	# Handle movement
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		# Movement affected by current rotation
		var effective_speed = move_speed * (1.0 + sin(rotation) * rotation_influence)
		velocity.x += direction * effective_speed * delta
		angular_velocity += direction * roll_speed * delta
		
		# Add some unpredictability to rotation
		if is_on_floor():
			angular_velocity += direction * sin(rotation) * roll_speed * 0.5 * delta
	
	# Apply momentum and bounds
	velocity.x *= momentum_factor
	angular_velocity *= momentum_factor
	
	# Cap maximum speeds to prevent total loss of control
	velocity.x = clamp(velocity.x, -move_speed * 2, move_speed * 2)
	angular_velocity = clamp(angular_velocity, -PI * 2, PI * 2)
	
	# Apply rotation
	rotation += angular_velocity * delta
	
	move_and_slide()
