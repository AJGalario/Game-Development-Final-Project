# loading_screen.gd
extends Node

@export var next_scene_path: String = "res://main_game.tscn"
var _loading_progress = []

func _ready():
	ResourceLoader.load_threaded_request(next_scene_path)

func _process(_delta):
	var status = ResourceLoader.load_threaded_get_status(next_scene_path, _loading_progress)
	match status:
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			$ProgressBar.value = _loading_progress[0] * 100  # 👈 ADD THIS LINE HERE
			
		ResourceLoader.THREAD_LOAD_LOADED:
			var scene = ResourceLoader.load_threaded_get(next_scene_path)
			get_tree().change_scene_to_packed(scene)
			
		ResourceLoader.THREAD_LOAD_FAILED:
			print("Load failed!")
