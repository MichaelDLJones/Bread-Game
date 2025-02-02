extends SoftBody2D

@export var target: CharacterBody2D  # Assign in the editor

func _process(_delta):
	if target:
		global_position = target.global_position
