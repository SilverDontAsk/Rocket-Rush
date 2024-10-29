extends CharacterBody2D

func _physics_process(_delta):
	# Movement logic
	if Input.is_action_pressed("Right"):
		self.velocity.x = get_parent().player_speed  # Accessing player_speed from parent
	elif Input.is_action_pressed("Left"):
		self.velocity.x = -get_parent().player_speed
	else:
		self.velocity.x = 0.0

	if Input.is_action_pressed("Down"):
		self.velocity.y = get_parent().player_speed
	elif Input.is_action_pressed("Up"):
		self.velocity.y = -get_parent().player_speed
	else:
		self.velocity.y = 0.0

	move_and_slide()

	# Smooth movement
	velocity.x = lerp(velocity.x, 0.0, 0.1)
	velocity.y = lerp(velocity.y, 0.0, 0.1)

func _on_area_2d_area_entered(area: Area2D):
	if area.is_in_group("enemy"):
		GlobalScript.Damage += 25
		if GlobalScript.Damage >= 100:
			var current_score = GlobalScript.points
			if current_score > GlobalScript.highscore:
				GlobalScript.highscore = current_score
				GlobalScript.save_highscore()
			get_tree().change_scene_to_file("res://Main/Single Mode/Scenes/GameOver.tscn")
