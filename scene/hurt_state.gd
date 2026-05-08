extends State
class_name HurtState

#@onready var hurt_sfx = [
	#$"../../Audio/Hurt/hurt_sfx_1",
	#$"../../Audio/Hurt/hurt_sfx_2",
	#$"../../Audio/Hurt/hurt_sfx_3",
#]

var hurt_duration = 0.5
var hurt_timer = 0.0
var knockback_direction = 1

func enter():
	print("Entering hurt state")
	player_animation.play("Move_Hurt")
	#hurt_sfx.pick_random().play()
	hurt_timer = hurt_duration
	
	var character = state_machine.player
	character.velocity.x = knockback_direction * -300
	character.velocity.y = -200

func physics_update(delta: float):
	var character = state_machine.player
	
	# Apply gravity
	character.velocity.y += GRAVITY * delta
	character.move_and_slide()
	
	# Count down and return to idle when done
	hurt_timer -= delta
	if hurt_timer <= 0.0:
		state_machine.change_state("idlestate")
