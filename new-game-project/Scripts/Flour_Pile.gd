extends Area2D

@export var smoke: AnimatedSprite2D

var flour_meter_path: NodePath
var flour_meter: ProgressBar
<<<<<<< HEAD
const FlourPile = preload("res://Scripts/Flour_Pile.gd")
=======
#var smoke: AnimatedSprite2D
>>>>>>> 3bfbe36a54be753939a2cfea79efa9435a65b9c6

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered)
	
	if get_parent().has_meta("Flour_Meter"):
		flour_meter_path = get_parent().get_meta("Flour_Meter")
		flour_meter = get_parent().get_node(flour_meter_path)
		
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body):
	if (body.name == "CharacterBody2D"):
		#print("collision")
		flour_meter.flour = 100.0
		if (smoke):
			smoke.play("Smoke")
		
