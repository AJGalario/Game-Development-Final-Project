extends Area2D

@export var target_destination: String = ""
@export var teleport_destination: Marker2D

func _ready():
	if not body_entered.is_connected(_on_body_entered):
		body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	print("body entered: ", body.name, " groups: ", body.get_groups())
	if body.is_in_group("player"):
		if teleport_destination:
			body.call_deferred("set", "global_position", teleport_destination.global_position)
		elif target_destination != "":
			var loading_screen = get_tree().root.get_node_or_null("loading_screen")
			if loading_screen and loading_screen.has_method("load_scene"):
				loading_screen.load_scene(target_destination)
			else:
				get_tree().change_scene_to_file(target_destination)
