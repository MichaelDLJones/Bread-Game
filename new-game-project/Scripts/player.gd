extends CharacterBody2D

@export var move_speed: float = 300.0
@export var jump_velocity: float = -400.0
@export var roll_speed: float = 2.0

@onready var sprite: Sprite2D = $Sprite2D

func _physics_process(delta: float) -> void:
	# Apply gravity.
	if not is_on_floor():
		velocity.y += ProjectSettings.get("physics/2d/default_gravity") * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity

	# Handle movement and rotation.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * move_speed
		rotation += direction * roll_speed * delta
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)

	move_and_slide()
