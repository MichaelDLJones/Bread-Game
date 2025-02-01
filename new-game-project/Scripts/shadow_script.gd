extends Node2D

@export var target_viewport_path: NodePath
@export var target_shadow_Sprite: Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	if not target_viewport_path:
		push_error("Target viewport path is not set!")
		return
		
	var target_viewport = get_node(target_viewport_path)
	if not target_viewport:
		push_error("could not find the target viewport at: " + str(target_viewport_path))
		return
		
	var original_transform = target_shadow_Sprite.global_transform
	
	if target_shadow_Sprite:
		remove_child(target_shadow_Sprite)
	else:
		push_error("This node does not have a parent!")
		return
		
	target_viewport.add_child(target_shadow_Sprite)
	
	target_shadow_Sprite.global_transform = original_transform


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
