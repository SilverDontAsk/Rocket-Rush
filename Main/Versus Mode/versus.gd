extends Node2D

var pre_enemyShip = preload("res://Main/Single Mode/Scenes/enemyship.tscn")
var pre_asteroid = preload("res://Main/Single Mode/Scenes/asteroid.tscn")
var pre_asteroid2 = preload("res://Main/Single Mode/Scenes/asteroids_2.tscn")
var pre_enemyShip2 = preload("res://Main/Single Mode/Scenes/enemyship_2.tscn")
var pre_player = preload("res://Main/Versus Mode/Player2.tscn")  # Asegúrate de que la ruta sea correcta
var time_accumulated = 0.0  # Variable para rastrear el tiempo transcurrido
var time_alive = 0.0  # Rastrear el tiempo de vida
var player_speed = 350
var enemy_speed = 500
var speed_increase_timer = 0.0 

func _ready():
	pass

func _on_timer_timeout():
	randomize()
	var randomEnemy = round(randf_range(1.0, 4.0))

	if randomEnemy == 1:
		var enemyShip = pre_enemyShip.instantiate()
		self.call_deferred("add_child", enemyShip)
		enemyShip.position.x = round(randf_range(0.0, 500.0))
		enemyShip.add_to_group("enemy")
		
	elif randomEnemy == 2:
		var asteroid = pre_asteroid.instantiate()
		self.call_deferred("add_child", asteroid)
		asteroid.position.x = round(randf_range(0.0, 500.0))
		asteroid.add_to_group("enemy")
		
	elif randomEnemy == 3:
		var asteroid2 = pre_asteroid2.instantiate()
		self.call_deferred("add_child", asteroid2)
		asteroid2.position.x = round(randf_range(0.0, 500.0))
		asteroid2.add_to_group("enemy")
		
	elif  randomEnemy == 4:
		var enemyShip2 = pre_enemyShip2.instantiate()
		self.call_deferred("add_child", enemyShip2)
		enemyShip2.position.x = round(randf_range(0.0, 500.0))
		enemyShip2.add_to_group("enemy")

func _physics_process(delta):
	speed_increase_timer += delta
	if speed_increase_timer >= 15.0:
		enemy_speed = min(enemy_speed + 50, 1000)
		speed_increase_timer = 0.0

	# Actualiza puntos cada segundo
	time_accumulated += delta
	if time_accumulated >= 1.0:
		GlobalScript.points += 1
		time_accumulated = 0.0  # Reiniciar el temporizador
	
	# Actualiza el HUD con puntos y daño
	$HUD/PuntosCantidad.text = str(GlobalScript.points)
	$HUD/DamageCantidad.text = str(GlobalScript.Damage2)
	
	$HUD2/PuntosCantidad.text = str(GlobalScript.points)
	$HUD2/DamageCantidad.text = str(GlobalScript.Damage)

func reset_game():
	GlobalScript.points = 0
	GlobalScript.Damage = 0
	
func game_over():
	var current_score = GlobalScript.points
	if current_score > GlobalScript.highscore:
		GlobalScript.highscore = current_score
		GlobalScript.save_highscore()
	get_tree().change_scene_to_file("res://Main/Single Mode/Scenes/GameOver.tscn")
