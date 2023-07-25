extends CharacterBody3D

@export var speed = 5.0

func _physics_process(delta: float) -> void:

	velocity = Vector3.BACK * speed
	move_and_slide()


func _on_top_trigger_body_entered(body: Node3D) -> void:
		if not body.is_in_group("player"): return
		body.global_position = $Marker.global_position
		$TopTrigger.queue_free()
