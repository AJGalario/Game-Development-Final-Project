# scene_manager.gd (add as Autoload)
extends Node

var _loading_scene_path: String = "res://loading_screen.tscn"

func change_scene(path: String):
	LoadingScreen.next_scene = path
	get_tree().change_scene_to_file(_loading_scene_path)
