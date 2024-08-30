extends Control

func _ready():
	if get_tree().paused:
		show()
	else:
		hide()

func control_menu():
	get_tree().paused = !get_tree().paused

	if get_tree().paused:
		show()
	else:
		hide()

func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		control_menu()
		
func _on_resume_pressed():
	control_menu()


func _on_restart_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_quit_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_options_pressed():
	$Options.show()
