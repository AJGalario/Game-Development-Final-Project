extends State
class_name WalkState

func enter():
	print("Entering walk state")
	player_animation.play("Move_Walk")

func physics_update(delta: float):
	var character = state_machine.player

	var direction = Input.get_axis("move_left", "move_right")

	character.velocity.x = direction * WALK_SPEED
	character.move_and_slide()
	
		# Player sprite direction
	if direction > 0:
		player_sprite.flip_h = false
	elif direction < 0:
		player_sprite.flip_h = true

	# Idle
	if direction == 0:
		state_machine.change_state("idlestate")
		return
	
	# Jump
	if Input.is_action_just_pressed("move_jump") && character.is_on_floor():
		state_machine.change_state("jumpstate")
		return
	
	# Fall
	if not character.is_on_floor():
		state_machine.change_state("fallstate")

func handle_input(event: InputEvent):
	if event.is_action_pressed("move_dash") and dash_state.dash_ready:
		state_machine.change_state("dashstate")
	
	if event.is_action_pressed("attack_tap"):
		state_machine.change_state("bowshoottap")
