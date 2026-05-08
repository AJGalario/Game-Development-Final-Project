extends CharacterBody2D

enum CrabState { PATROL, ATTACK }
var state: CrabState = CrabState.PATROL

# Patrol settings
var patrol_speed: float = 80.0
var patrol_range: float = 150.0
var start_position: Vector2
var patrol_direction: float = 1.0

# Attack settings
var attack_speed: float = 150.0
var attack_damage: int = 10
var attack_cooldown: float = 1.0
var attack_timer: float = 0.0

# Gravity
var gravity: float = 900.0

# Player reference
var player: CharacterBody2D = null

func _ready() -> void:
	start_position = global_position

func _physics_process(_delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * _delta
	attack_timer -= _delta
	match state:
		CrabState.PATROL:
			_patrol(_delta)
		CrabState.ATTACK:
			_attack(_delta)
	move_and_slide()

func _patrol(_delta: float) -> void:
	velocity.x = patrol_speed * patrol_direction
	var distance_from_start = global_position.x - start_position.x
	if distance_from_start > patrol_range:
		patrol_direction = -1.0
		$Sprite2D.flip_h = true
	elif distance_from_start < -patrol_range:
		patrol_direction = 1.0
		$Sprite2D.flip_h = false
	if is_on_wall():
		var collision = get_last_slide_collision()
		if collision and collision.get_collider() is TileMapLayer:
			patrol_direction *= -1.0
			global_position.x += patrol_direction * 5.0

func _attack(_delta: float) -> void:
	if player == null:
		state = CrabState.PATROL
		return
	var direction = sign(player.global_position.x - global_position.x)
	velocity.x = attack_speed * direction
	$Sprite2D.flip_h = direction < 0
	var horizontal_dist = abs(player.global_position.x - global_position.x)
	var vertical_dist = abs(player.global_position.y - global_position.y)
	if horizontal_dist < 50.0 and vertical_dist < 60.0 and attack_timer <= 0.0:
		player.take_damage(attack_damage)
		attack_timer = attack_cooldown

func _on_detection_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = body
		state = CrabState.ATTACK

func _on_detection_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = null
		state = CrabState.PATROL
