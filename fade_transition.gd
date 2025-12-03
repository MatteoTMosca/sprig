extends CanvasLayer

signal transitioned

func _ready() -> void:
	$AnimationPlayer.play("fade_to_normal")

func transition():
	if Global.transitioning:
		$AnimationPlayer.play("fade_to_black")
		await get_tree().create_timer(0.5).timeout
		$AnimationPlayer.play("fade_to_normal")
		
	
	
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "fade_to_black":
		emit_signal("transitioned")
	
	
func _process(delta: float) -> void:
	if Global.transitioning:
		$AnimationPlayer.play("fade_to_black")
		await get_tree().create_timer(0.5).timeout
		$AnimationPlayer.play("fade_to_normal")
		
		
