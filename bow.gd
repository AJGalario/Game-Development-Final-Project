extends Node2D

@onready var shooting_point: Marker2D = $Marker2D/BowDrawSprite/ShootingPoint

func shoot():
	print("Shooting")
	# Loads the scene at the start of the game
	const ARROW = preload("res://scene/arrow.tscn")
	
	# Instantiate a new arrow
	var new_arrow = ARROW.instantiate()
	
	# Places the new arrow onto the shooting point (tip of the bow)
	new_arrow.global_position = shooting_point.global_position
	
	new_arrow.global_rotation = shooting_point.global_rotation + deg_to_rad(225)
	
	# Adds the arrow instance as a child to the shooting point
	shooting_point.add_child(new_arrow)
