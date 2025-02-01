extends Camera2D

@export var shadow_camera_path: NodePath
@export var shadow_render_path: NodePath

var shadow_camera: Camera2D
var shadow_render: TextureRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	shadow_camera = get_node(shadow_camera_path)
	if not shadow_camera:
		push_error("Shadow camera not found!")
		
	shadow_render = get_node(shadow_render_path)
	if not shadow_render:
		push_error("Shadow render not found!")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if shadow_camera:
		shadow_camera.global_position = global_position
		shadow_camera.zoom = zoom
		shadow_camera.rotation = rotation
	if shadow_render:
		var zoom_invers = Vector2(1.0,1.0) / zoom
		shadow_render.global_position = global_position - ((shadow_render.size/2.0) * zoom_invers)
		shadow_render.scale = zoom_invers
		
