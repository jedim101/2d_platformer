extends Node

var unlocked_level = 1

var music_volume = 0.5
var sounds_volume = 0.5

func _adjust_music_volume(new_volume: float):
  music_volume = new_volume
  BackgroundMusic.volume_db = 70 * new_volume -70

  if new_volume == 0:
    BackgroundMusic.stop()
  elif not BackgroundMusic.playing:
    BackgroundMusic.play()

func _adjust_sounds_volume(new_volume: float):
  sounds_volume = new_volume
