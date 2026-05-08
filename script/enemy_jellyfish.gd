extends Enemy
class_name JellyfishEnemy

@onready var jellyfish_animation : AnimationPlayer = $AnimationPlayer

func _ready():
	jellyfish_animation.play("Jellyfish_Idle")
	current_health = max_health

func _process(_delta: float) -> void:
	if current_health <= 0:
		queue_free()

func take_damage(damage: int):
	current_health -= damage
