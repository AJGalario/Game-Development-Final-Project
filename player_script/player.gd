extends CharacterBody2D
class_name Player

signal dash_cooldown_updated(time_left)
signal health_changed(new_health)  # optional, for UI

@onready var dash_cooldown_timer: Timer = $StateMachine/DashState/DashCooldownTimer
@onready var bow_draw_sprite: Sprite2D = $BowAnimation/Marker2D/BowDrawSprite
@onready var player_bow_arrow_sprite: Sprite2D = $"BowAnimation/PlayerBow&ArrowSprite"

# Health
var max_health: int = 100
var current_health: int = 100
var is_invincible: bool = false
var invincibility_duration: float = 1.0  # seconds of invincibility after hit

func _ready():
	player_bow_arrow_sprite.visible = false
	bow_draw_sprite.frame = 0

func _process(delta):
	if not dash_cooldown_timer.is_stopped():
		emit_signal("dash_cooldown_updated", dash_cooldown_timer.time_left)
	else:
		emit_signal("dash_cooldown_updated", 0.0)

func take_damage(amount: int) -> void:
	if is_invincible:
		return
	current_health -= amount
	emit_signal("health_changed", current_health)
	if current_health <= 0:
		die()
	else:
		# Brief invincibility after being hit
		is_invincible = true
		await get_tree().create_timer(invincibility_duration).timeout
		is_invincible = false

func die() -> void:
	# For now just respawn at SpawnPoint
	var spawn = get_tree().current_scene.find_child("SpawnPoint")
	if spawn:
		global_position = spawn.global_position
	current_health = max_health
