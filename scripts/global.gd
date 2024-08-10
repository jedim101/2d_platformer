extends Node

var unlocked_level = 1
var paused = false

func _process(_delta):
  if paused:
    Engine.time_scale = 0
  else:
    Engine.time_scale = 1