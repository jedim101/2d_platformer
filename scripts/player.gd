extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -500.0
const PUSH_FORCE = 50

var animation = "walking"

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	$Sprite2D/FrameAnimator.play("RESET")

func _physics_process(delta):
	var speed = SPEED * scale.x
	var jump_velocity = JUMP_VELOCITY * sqrt(scale.y)

	if not is_on_floor():
		velocity.y += gravity * delta
	elif animation == "jumping":
		animation = "walking"

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
		animation = "jumping"
		$Sprite2D/FrameAnimator.play(animation)


	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	if velocity.x < 0:
		$Sprite2D.flip_h = true
		$FrontArea.position.x = -49 - $FrontArea/CollisionShape2D.shape.size.x
	elif velocity.x > 0:
		$Sprite2D.flip_h = false
		$FrontArea.position.x = 0

	if velocity.x != 0 and not $Sprite2D/FrameAnimator.is_playing() and is_on_floor():


		$Sprite2D/FrameAnimator.play(animation)

		$AudioStreamPlayer.volume_db = 80 * Global.sounds_volume -80

		if Global.sounds_volume > 0:
			$AudioStreamPlayer.play()

	elif animation == "walking" and (velocity.x == 0 or not is_on_floor()): 
		$Sprite2D/FrameAnimator.stop()
		$AudioStreamPlayer.stop()
	
	if not is_on_floor() and not animation == "jumping":
		$Sprite2D.frame = 14
		animation = "walking"

	move_and_slide()

	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() in get_tree().get_nodes_in_group("boxes"):
			c.get_collider().apply_central_impulse(-c.get_normal() * PUSH_FORCE)

func _on_area_2d_body_entered(body:Node2D):
	if body in get_tree().get_nodes_in_group("boxes"):
		animation = "pushing"
		$Sprite2D/FrameAnimator.stop()


func _on_area_2d_body_exited(body:Node2D):
	if body in get_tree().get_nodes_in_group("boxes"):
		animation = "walking"
		$Sprite2D/FrameAnimator.play("RESET")
