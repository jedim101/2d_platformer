extends Area2D

var disabled = false

func _ready():
	$Sprite2D/PortalAnimator.play("portal")

func _on_body_entered(body):
	if body is StaticBody2D:
		return

	for portal in get_tree().get_nodes_in_group("portal"):
		if self != portal:
			var height: int = body.global_scale.y
			if body is RigidBody2D:
				height = body.get_child(0).global_scale.y

			if portal.disabled or global_scale.y < height:
				break

			disabled = true

			var scale_factor = portal.global_scale / global_scale

			body.global_position = portal.global_position - (global_position - body.global_position) * scale_factor

			if body is RigidBody2D:
				body.mass *= scale_factor.x * scale_factor.y
				for child in body.get_children():
					child.apply_scale(scale_factor)
			else:
				body.global_scale *= scale_factor

			await get_tree().create_timer(0.1).timeout
			disabled = false

			break
