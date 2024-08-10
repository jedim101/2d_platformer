extends Area2D


func _on_body_entered(body):
	if body is CharacterBody2D:
		var next_level = int(get_tree().current_scene.name.substr(6)) + 1
		Global.unlocked_level = max(Global.unlocked_level, next_level)
		
		get_tree().change_scene_to_file("res://scenes/level_" + str(next_level) + ".tscn")
