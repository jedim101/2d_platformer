extends Area2D

var disabled = false

func _on_body_entered(body):
	if body is StaticBody2D:
		return

	for portal in get_tree().get_nodes_in_group("portal"):
		if self != portal:
			if portal.disabled or global_scale.y < body.global_scale.y:
				break

			disabled = true

			var scale_factor = portal.global_scale / global_scale

			body.global_position = portal.global_position - (global_position - body.global_position) * scale_factor
			print(scale_factor)

			if body is RigidBody2D:
				for child in body.get_children():
					child.global_scale *= scale_factor
			else:
				body.global_scale *= scale_factor

			await get_tree().create_timer(0.1).timeout
			disabled = false

			break
