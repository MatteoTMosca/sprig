extends Node2D

var state = "full"
var player_is_in_area = false

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	if state == "empty":
		$AnimatedSprite2D_bottom.play("empty")
		$AnimatedSprite2D_top.play("empty"	)
	if state == "full":
		$AnimatedSprite2D_bottom.play("full")
		$AnimatedSprite2D_top.play("full")
		if player_is_in_area:
			if Input.is_action_just_pressed("e"):
				state = "empty"
				print("Ornament +1")




func _on_pickable_area_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_is_in_area = true


func _on_pickable_area_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_is_in_area = false
	
