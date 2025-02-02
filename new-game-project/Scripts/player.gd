extends CharacterBody2D

@export var speed: float = 200.0
@export var jump_force: float = 300.0
@export var damping: float = 0.9
@export var max_velocity: float = 400.0

var velocity: Vector2 = Vector2.ZERO
var gravity: Vector2 = Vector2(0, 980)

func _physics_process(delta: float):
	var input_dir = Vector2.ZERO
	if Input.is_action_pressed("move_left"):
		input_dir.x -= 1
	if Input.is_action_pressed("move_right"):
		input_dir.x += 1
	
	if input_dir.length() > 0:
		input_dir = input_dir.normalized() * speed
	
	velocity += input_dir * delta
	velocity += gravity * delta
	velocity *= damping
	velocity = velocity.limit_length(max_velocity)
	
	move_and_slide()
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_force
