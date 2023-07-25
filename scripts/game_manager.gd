extends Node3D


func _ready() -> void:
	get_tree().create_timer(5).timeout.connect(func(): $StartingPlatform.queue_free())

func _on_ground_body_entered(body: Node3D) -> void:
	if not body.is_in_group("player"): return
	body.die()

func _on_player_died() -> void:
	await get_tree().create_timer(2).timeout
	get_tree().reload_current_scene()
