extends Control

func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/levels.tscn")


func _on_options_pressed():
	$Options.show()


func _on_help_btn_pressed():
	$Help.show()
