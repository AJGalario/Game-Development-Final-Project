# HoldZoomCamera.gd
extends Camera2D

@export var zoom_out_multiplier := 0.3   # how far to zoom out
@export var zoom_speed := 6.0            # smoothness

var base_zoom : Vector2
var target_zoom : Vector2

func _ready():
	base_zoom = zoom                # read Inspector zoom
	target_zoom = base_zoom

func _process(delta):
	# smooth interpolation
	zoom = zoom.lerp(target_zoom, zoom_speed * delta)

func _input(event):
	if event.is_action_pressed("zoom_out"):
		print("Zooming out")
		target_zoom = base_zoom * zoom_out_multiplier
		
	if event.is_action_released("zoom_out"):
		print("Zooming in")
		target_zoom = base_zoom
