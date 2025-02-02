extends Area2D

@export var smoke: AnimatedSprite2D

var flour_meter_path: NodePath
var flour_meter: ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered)
	
	if get_parent().has_meta("Flour_Meter"):
		flour_meter_path = get_parent().get_meta("Flour_Meter")
		flour_meter = get_parent().get_node(flour_meter_path)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_body_entered(body):
	if (body.name == "CharacterBody2D"):
		#print("collision")
		if (flour_meter_path):
			flour_meter.flour = 100.0
		else:
			push_error("Meta data not assigned or assigned incorrectly")
			
		if (smoke):
			#print("smoke")
			smoke.play("Smoke")
		
