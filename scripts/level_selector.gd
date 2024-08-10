extends Button

func _ready():
	if int(text) > Global.unlocked_level:
		disabled = true

func _on_pressed():
	get_tree().change_scene_to_file("res://scenes/level_" + text + ".tscn")
