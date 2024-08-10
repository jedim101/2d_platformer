extends Control

func _ready():
	if Global.paused:
		show()
	else:
		hide()

func control_menu():
	Global.paused = !Global.paused

	if Global.paused:
		show()
	else:
		hide()

func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		control_menu()
		
func _on_resume_pressed():
	control_menu()


func _on_restart_pressed():
	pass # Replace with function body.


func _on_quit_pressed():
	Global.paused = !Global.paused
	get_tree().change_scene_to_file("res://scenes/main.tscn")