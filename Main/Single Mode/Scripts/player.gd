extends CharacterBody2D

var shield_points = 0
var shield_active = false

func _ready():
	pass
	
func activate_shield():
	if not shield_active:
		shield_active = true
		shield_points = 0
		print("Shield activado")
	
func deactivate_shield():
	if shield_active:
		shield_active = false
		print("Shield Desactivate")

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
	
	if shield_active:
		shield_points += 1  # Incrementa los puntos en cada cuadro
		print("Puntos del escudo: " + str(shield_points))  # Imprimir los puntos para depuración
		
		# Solo desactiva el escudo si los puntos alcanzan 10
		if shield_points >= 600:
			deactivate_shield()  # Desactiva el escudo

func _on_area_2d_area_entered(area: Area2D):
	if area.is_in_group("enemy"):
		if not shield_active:
			$sounds/shipImpact.play()
			GlobalScript.Damage += 25
		if GlobalScript.Damage >= 100:
			var current_score = GlobalScript.points
			if current_score > GlobalScript.highscore:
				GlobalScript.highscore = current_score
				GlobalScript.save_highscore()
			get_tree().change_scene_to_file("res://Main/Single Mode/Scenes/GameOver.tscn")
