extends Area2D
class_name SagittariusArrow

@onready var destroy_self_timer: Timer = $DestroySelfTimer
var speed := 500
var damage := 50

func _ready():
	destroy_self_timer.start()

func _physics_process(delta: float) -> void:
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * speed * delta

func _on_body_entered(body) -> void:
	if body is not Player:
		speed = 0
	
	if body.has_method("take_damage"):
		body.take_damage(damage)
		queue_free()

func _on_destroy_self_timer_timeout() -> void:
	queue_free()
