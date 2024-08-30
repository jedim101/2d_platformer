extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -500.0
const PUSH_FORCE = 50

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	var speed = SPEED * scale.x
	var jump_velocity = JUMP_VELOCITY * sqrt(scale.y)
	# var push_force = PUSH_FORCE * scale.x * scale.y

	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	if velocity.x < 0:
		$Sprite2D.flip_h = true
	else:
		$Sprite2D.flip_h = false

	if velocity.x != 0 and not $Sprite2D/FrameAnimator.is_playing() and is_on_floor():
		$Sprite2D/FrameAnimator.play("walking")

		$AudioStreamPlayer.volume_db = 80 * Global.sounds_volume -80

		if Global.sounds_volume > 0:
			$AudioStreamPlayer.play()
			
	elif velocity.x == 0 or not is_on_floor(): 
		$Sprite2D/FrameAnimator.stop()
		$AudioStreamPlayer.stop()

	move_and_slide()

	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			c.get_collider().apply_central_impulse(-c.get_normal() * PUSH_FORCE)