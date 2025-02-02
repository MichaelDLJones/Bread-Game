extends ProgressBar

@onready var timer = $Timer
@onready var flourmeter = $Flourmeter

var flour = 0 : set = _set_flour

func _set_flour(new_flour):
	var prev_flour = flour
	flour = min(max_value, new_flour)
	value = flour
	
	#if flour <= 0:
	#	queue_free()
		
	if flour < prev_flour:
		timer.start()
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
