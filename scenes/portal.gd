extends Area2D

var disabled = false

func _on_body_entered(body):
	if body is StaticBody2D:
		return

	for portal in get_tree().get_nodes_in_group("portal"):
		if self != portal:
			if portal.disabled or scale.y < body.scale.y:
				break

			disabled = true

			var scale_factor = portal.scale / scale

			body.global_position = portal.global_position - (global_position - body.global_position) * scale_factor

			# body.global_position += ( portal.global_position - body.global_position) * scale_factor
			
			# # b + (p - b) * s

			# p - (c - b)

			body.scale *= scale_factor

			await get_tree().create_timer(0.1).timeout
			disabled = false

			break
