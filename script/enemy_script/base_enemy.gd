extends Node
class_name Enemy

@export var max_health: int
var current_health: int

func _ready():
	current_health = max_health

func deal_damage(): pass
func take_damage(damage: int): pass
