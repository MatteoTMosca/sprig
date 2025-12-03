extends Area2D

var transition = preload("res://fade_transition.tscn")


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Global.transitioning = true
		await get_tree().create_timer(0.5).timeout
		#$fade_transition.transitioned()
		body.set_position($destination_point.global_position)
		Global.transitioning = false
