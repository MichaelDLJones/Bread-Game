extends ProgressBar

@onready var Timer1 = $Timer1
@onready var Timer2 = $Timer2
@onready var flourmeter = $Flourmeter
@onready var mgh: AudioStreamPlayer = $Mgh2

var flour = 0 : set = _set_flour

func _set_flour(new_flour):
	
	var prev_flour = flour
	flour = min(max_value, new_flour)
	value = flour
	
	if flour <= 0:
		mgh.play()
		Timer2.start()
		
	if flour < prev_flour:
		Timer1.start()
	else:
		flourmeter.value = flour

func init_flour(_flour):
	flour = _flour
	max_value = flour
	value = flour
	flourmeter.max_value = flour
	flourmeter.value = flour

func _on_timer_timeout() -> void:
	flourmeter.value = flour

func _on_timer_2_timeout() -> void:
	get_tree().reload_current_scene()
