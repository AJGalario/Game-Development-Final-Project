extends Area2D

@onready var spawn_point = $"../SpawnPoint"  # adjust path if needed

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body is Player:
		body.global_position = spawn_point.global_position
		body.velocity = Vector2.ZERO
		body.get_node("StateMachine").change_state("idlestate")
