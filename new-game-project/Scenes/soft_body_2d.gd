extends SoftBody2D

@export var speed: float = 500.0
@export var custom_damping: float = 0.9  # Helps stabilize movement

var velocity := Vector2.ZERO

func _physics_process(delta: float) -> void:
	var direction := Vector2.ZERO
	
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_down"):
		direction.y += 1
	if Input.is_action_pressed("move_up"):
		direction.y -= 1
	
	direction = direction.normalized()
	velocity = velocity.lerp(direction * speed, 0.1)
	velocity *= custom_damping  # Apply damping to smooth movement
	
	apply_impulse(global_position, velocity * delta)
