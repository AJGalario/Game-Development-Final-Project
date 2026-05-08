extends State
class_name FallState

func enter():
	print("Entering Fall State")
	player_animation.play("Move_Fall")

func physics_update(delta: float):
	var character = state_machine.player
	
	# Apply gravity to player
	character.velocity.y += GRAVITY * delta * 0.085
	if Input.is_action_pressed("move_down"):
		character.velocity.y += GRAVITY * delta * 0.75  # extra downward force
	
	# Let player move move left or right while in air
	var direction = Input.get_axis("move_left", "move_right")
	character.velocity.x = direction * WALK_SPEED
	character.move_and_slide()
	
	# Player sprite direction
	if direction > 0:
		player_sprite.flip_h = false
	elif direction < 0:
		player_sprite.flip_h = true
	
	# Transition to next state
	if character.is_on_floor():
		if direction != 0:
			state_machine.change_state("walkstate")
		else:
			state_machine.change_state("idlestate")

func handle_input(event: InputEvent):
	if event.is_action_pressed("move_dash") and dash_state.dash_ready:
		state_machine.change_state("dashstate")
	
	if event.is_action_pressed("attack_tap"):
		state_machine.change_state("bowshoottap")
