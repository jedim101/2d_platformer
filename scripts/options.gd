extends Control

func _ready():
	$VBoxContainer/Sliders/Music/MusicSlider.set_value_no_signal(Global.music_volume)
	$VBoxContainer/Sliders/Sounds/SoundsSlider.set_value_no_signal(Global.sounds_volume)


func _on_sounds_slider_value_changed(value):
	Global.sounds_volume = value

func _on_music_slider_value_changed(value):
	Global._adjust_music_volume(value)


func _on_done_pressed():
	hide()