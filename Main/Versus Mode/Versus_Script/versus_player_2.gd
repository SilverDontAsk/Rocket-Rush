extends CharacterBody2D

var shield_points = 0
var shield_active = false

func _ready():
	pass
	
func activate_shield():
	if not shield_active:
		shield_active = true
		shield_points = 0
		print("Escudo activado para Jugador 2")
	
func deactivate_shield():
	if shield_active:
		shield_active = false
		print("Escudo desactivado para Jugador 2")

func _physics_process(_delta):
	# Movimiento del jugador
	if Input.is_action_pressed("2right"):
		self.velocity.x = get_parent().player_speed  # Accediendo a player_speed desde el padre
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

	# Suavizado de movimiento
	velocity.x = lerp(velocity.x, 0.0, 0.1)
	velocity.y = lerp(velocity.y, 0.0, 0.1)
	
	if shield_active:
		shield_points += 1  # Incrementa los puntos en cada cuadro
		print("Puntos del escudo para Jugador 2: " + str(shield_points))  # Imprimir los puntos para depuración
		
		# Solo desactiva el escudo si los puntos alcanzan 600
		if shield_points >= 600:
			deactivate_shield()  # Desactiva el escudo

func _on_area_2d_area_entered(area: Area2D):
	if area.is_in_group("VersusEnemy"):
		if not shield_active:
			$sounds/shipImpact.play()
			VersusGlobal.add_damage(2, 25)
			print("Jugador 2 ha recibido daño. Daño acumulado: " + str(VersusGlobal.player2_damage))
			VersusGlobal.check_game_over()
