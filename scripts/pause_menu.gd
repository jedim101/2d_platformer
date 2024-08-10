extends Control

func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		Global.paused = !Global.paused

		if Global.paused:
			show()
			Engine.time_scale = 0
		else:
			hide()
			Engine.time_scale = 1
		
