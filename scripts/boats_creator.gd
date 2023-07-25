extends Node3D

@export var boat_scene: PackedScene

func _on_timer_timeout() -> void:
	create_boat()
	
func create_boat():
	var boat = boat_scene.instantiate()
	var marker = $Markers.get_children().pick_random()
	boat.position = marker.position
	add_child(boat)
