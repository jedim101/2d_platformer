extends Area2D


func _on_body_entered(body):
	if body is CharacterBody2D && body.global_scale.y <= global_scale.y:
		var next_level = int(get_tree().current_scene.name.substr(6)) + 1
		Global.unlocked_level = max(Global.unlocked_level, next_level)

		var next_level_file = "res://scenes/level_" + str(next_level) + ".tscn"
		
		$AudioStreamPlayer.volume_db = 60 * Global.sounds_volume -60

		if Global.sounds_volume > 0:
			$AudioStreamPlayer.play()

		await get_tree().create_timer(0.6).timeout
		get_tree().change_scene_to_file(next_level_file if ResourceLoader.exists(next_level_file) else "res://scenes/you_win.tscn")
