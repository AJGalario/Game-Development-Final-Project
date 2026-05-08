extends State
class_name BowShootTap

@onready var player_freeze_after_shooting_timer: Timer = $PlayerShootingTimer
@onready var timer_before_fire: Timer = $TimerBeforeFire

var player_can_move := false

func enter():
	print("Shooting bow tap")
	player_can_move = false
	
	player_sprite.visible = false
	player_bow_arrow_sprite.visible = true
	
	player_animation.play("Bow_Tap_Attack")
	
	player_freeze_after_shooting_timer.start()
	timer_before_fire.start()

func physics_update(delta: float):
	var character = state_machine.player
	var direction = Input.get_axis("move_left", "move_right")
	
	# Flip character sprite horizontally depending on mouse position
	var mouse_x = bow_pivot.get_global_mouse_position().x
	var player_x = state_machine.player.global_position.x
	
	if mouse_x > player_x:
		player_bow_arrow_sprite.flip_h = false
	else:
		player_bow_arrow_sprite.flip_h = true
	
	if player_can_move:
		player_sprite.visible = true
		player_bow_arrow_sprite.visible = false
		
		# Idle
		if direction == 0:
			state_machine.change_state("idlestate")
			return
		
		if direction != 0:
			state_machine.change_state("walkstate")
		
		# Jump
		if Input.is_action_just_pressed("move_jump") && character.is_on_floor():
			state_machine.change_state("jumpstate")
			return
		
		# Fall
		if not character.is_on_floor():
			state_machine.change_state("fallstate")

func _on_player_shooting_timer_timeout() -> void:
	player_can_move = true

func _on_timer_before_fire_timeout() -> void:
	bow_animation.shoot()
