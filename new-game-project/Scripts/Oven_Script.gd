extends Area2D
 
@export var oven_door: AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body):
	if (body.name == "CharacterBody2D"):
		if (oven_door):
			print("oven")
			oven_door.play("Oven_Door")
