extends Control

@onready var cooldown_label: Label = $PlayerUI/DashCooldown/VBoxContainer/CooldownTime
@onready var health_bar: ProgressBar = $PlayerUI/HealthBar/ProgressBar
var player: Player = null

func _ready():
	player = get_parent().get_parent() as Player
	if player == null:
		player = get_tree().current_scene.find_child("Player") as Player
	if player:
		player.connect("dash_cooldown_updated", _on_dash_cooldown_updated)
		player.connect("health_changed", _on_health_changed)
		health_bar.max_value = player.max_health
		health_bar.value = player.current_health
	else:
		push_error("InGameUI: Could not find Player node!")

func _on_dash_cooldown_updated(time_left):
	cooldown_label.text = str(round(time_left * 10) / 10.0)

func _on_health_changed(new_health: int) -> void:
	health_bar.value = new_health
