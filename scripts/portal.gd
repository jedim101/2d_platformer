extends Area2D

var disabled = false

func _ready():
	$Sprite2D/PortalAnimator.play("portal")

func _on_body_entered(body):
	if body is StaticBody2D:
		return

	for portal in get_tree().get_nodes_in_group("portal"):
		if self != portal && self.get_meta("value") == portal.get_meta("value"):
			var body_scale = body.global_scale
			if body is RigidBody2D:
				body_scale = body.get_child(0).global_scale

			if portal.disabled or global_scale.y < body_scale.y or global_scale.x < body_scale.x:
				break

			disabled = true

			var scale_factor = portal.global_scale / global_scale


			$PortalSound.stream = preload("res://assets/portal_normal.wav") if scale_factor.y == 1 else preload("res://assets/portal_up.wav") if scale_factor.y > 1 else preload("res://assets/portal_down.wav")
			$PortalSound.play()

			body.global_position = portal.global_position - (global_position - body.global_position) * scale_factor

			if body is RigidBody2D:
				for child in body.get_children():
					child.apply_scale(scale_factor)
			else:
				body.global_scale *= scale_factor

			await get_tree().create_timer(0.1).timeout
			disabled = false

			break
