extends Area2D

var disabled = false

func _on_area_entered(area):
	if disabled:
		print("disabled")
		return
	
	print("hello")
	for portal in get_tree().get_nodes_in_group("portal"):
		print(portal)
		if self != portal:
			print(portal.global_position)
			area. = portal.position
	
	disabled = true