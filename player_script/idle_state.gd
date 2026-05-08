extends State
class_name IdleState

func enter():
	print("Entering idle state")
	player_animation.play("Move_Idle")

func physics_update(delta: float):
	var character = state_machine.player
	
	var direction = Input.get_axis("move_left", "move_right")
	
	# Fall
	if not character.is_on_floor():
		state_machine.change_state("fallstate")
	
	# Jump
	if Input.is_action_just_pressed("move_jump"):
		state_machine.change_state("jumpstate")
	
	# Walk
	if direction != 0:
		state_machine.change_state("walkstate")

func handle_input(event: InputEvent):
	if event.is_action_pressed("move_dash") and dash_state.dash_ready:
		state_machine.change_state("dashstate")

	if event.is_action_pressed("attack_tap"):
		state_machine.change_state("bowshoottap")
