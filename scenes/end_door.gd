extends Area2D


func _on_body_entered(body):
	if body is StaticBody2D:
		return
	
	get_tree().change_scene_to_file("res://scenes/level_" + str(int(get_tree().current_scene.name.right(1)) + 1) + ".tscn")

	pass # Replace with function body.
