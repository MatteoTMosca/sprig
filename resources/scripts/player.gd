extends CharacterBody2D

var speed = 100

var player_state

var ornament_equipped = true
var ornament_cooldown = true
var ornament = preload("res://resources/scene/ornament.tscn")

func _physics_process(delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	
	#if direction.x == 0 and direction.y == 0:
		#player_state = "idle"
	#elif direction.x != 0 or direction.y != 0:
		#player_state = "walking"
		

	
		
	velocity = direction * speed 
	move_and_slide()
	
	if Input.is_action_just_pressed("o") and ornament_equipped and ornament_cooldown:
		ornament_cooldown = false 
		var ornament_instance = ornament.instantiate()
		ornament_instance.rotation = $Marker2D.rotation
		ornament_instance.global_position = $Marker2D.global_position
		add_child(ornament_instance)
		
		
		await get_tree().create_timer(0.4).timeout
		ornament_cooldown = true
	
	if velocity.is_zero_approx():
		player_state = "idle"
	else:
		player_state = "walking"
	
	play_anim(direction)
	
func play_anim(dir):
	
	if player_state == "walking":
		if dir.y < 0:
			$AnimatedSprite2D.play('n_walk')
		if dir.x == 1:
			$AnimatedSprite2D.play("e_walk")
		if dir.y > 0:
			$AnimatedSprite2D.play("s_walk")
		if dir.x == -1:
			$AnimatedSprite2D.play('w_walk')
	
	if player_state =="idle" and velocity.is_zero_approx():
		if Input.is_action_just_released("up"):
			$AnimatedSprite2D.play("n_idle")
			#$Marker2D.rotation_degrees = 270 
		if Input.is_action_just_released("down"):
			$AnimatedSprite2D.play("idle")
			#$Marker2D.rotation_degrees = 90
		if Input.is_action_just_released("left"):
			$AnimatedSprite2D.play("w_idle")
			#$Marker2D.rotation_degrees = 180
		if Input.is_action_just_released("right"):
			$AnimatedSprite2D.play("e_idle")
			#$Marker2D.rotation_degrees = 0
			
		

func _process(delta: float) -> void:
	if $AnimatedSprite2D.animation == "n_walk" or $AnimatedSprite2D.animation == ("n_idle"):
		$Marker2D.rotation_degrees = 270
	if $AnimatedSprite2D.animation == ("s_walk") or $AnimatedSprite2D.animation ==("idle"):
		$Marker2D.rotation_degrees = 90
	if $AnimatedSprite2D.animation == ("w_walk") or $AnimatedSprite2D.animation == ("w_idle"):
		$Marker2D.rotation_degrees = 180
	if $AnimatedSprite2D.animation == ("e_walk") or $AnimatedSprite2D.animation == ("e_idle"):
		$Marker2D.rotation_degrees = 0
	if Global.transitioning:
		speed = 0
		Input.cancel_free()
		await get_tree().create_timer(0.5).timeout
	else:
		speed = 100
		
		
	


func player():
	pass
