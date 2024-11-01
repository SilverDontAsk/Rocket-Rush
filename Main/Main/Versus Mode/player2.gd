extends CharacterBody2D

func _physics_process(_delta):
	# Movement logic
	if Input.is_action_pressed("2right"):
		self.velocity.x = get_parent().player_speed
	elif Input.is_action_pressed("2left"):
		self.velocity.x = -get_parent().player_speed
	else:
		self.velocity.x = 0.0

	if Input.is_action_pressed("2down"):
		self.velocity.y = get_parent().player_speed
	elif Input.is_action_pressed("2up"):
		self.velocity.y = -get_parent().player_speed
	else:
		self.velocity.y = 0.0

	move_and_slide()

	velocity.x = lerp(velocity.x, 0.0, 0.1)
	velocity.y = lerp(velocity.y, 0.0, 0.1)

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		GlobalScript.Damage2 += 25  # Aumentar el daño del jugador 2
		if GlobalScript.Damage2 >= 100:
			var current_score = GlobalScript.points
			if current_score > GlobalScript.highscore:
				GlobalScript.highscore = current_score
				GlobalScript.save_highscore()
			get_tree().change_scene_to_file("res://Titlescreen/GameOver.tscn")
