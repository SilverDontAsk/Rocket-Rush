extends Node2D

var pre_enemyShip = preload("res://Main/Single Mode/Scenes/enemyship.tscn")
var pre_asteroid = preload("res://Main/Single Mode/Scenes/asteroid.tscn")
var pre_asteroid2 = preload("res://Main/Single Mode/Scenes/asteroids_2.tscn")
var pre_enemyShip2 = preload("res://Main/Single Mode/Scenes/enemyship_2.tscn")
var pre_asteroid3 = preload("res://Main/Single Mode/Scenes/asteroid3.tscn")
var pre_medicine = preload("res://Main/Single Mode/Scenes/medicine.tscn")
var pre_shield = preload("res://Main/Single Mode/Scenes/shield.tscn")
var pre_enemyShip3 = preload("res://Main/Single Mode/Scenes/enemyship_3.tscn")
var player_speed = 400
var enemy_speed = 75
var time_accumulated = 0.0
var speed_increase_timer = 0.0
var points_needed_for_shield = 10
var shield_points = 0
var shield_active = false
var player_group = []
var enemy_group = []
var boost_group = []

func _ready():
	player_group = get_tree().get_nodes_in_group("player")
	enemy_group = get_tree().get_nodes_in_group("enemy")
	boost_group = get_tree().get_nodes_in_group("boost")

func _on_timer_timeout():
	randomize()
	var randomEnemy = round(randf_range(1.0, 6.0))

	if randomEnemy == 1:
		var enemyShip = pre_enemyShip.instantiate()
		self.call_deferred("add_child", enemyShip)
		enemyShip.position.x = round(randf_range(0.0, 1280.0))
		enemyShip.add_to_group("enemy")
		
	elif randomEnemy == 2:
		var asteroid = pre_asteroid.instantiate()
		self.call_deferred("add_child", asteroid)
		asteroid.position.x = round(randf_range(0.0, 1280.0))
		asteroid.add_to_group("enemy")
		
	elif randomEnemy == 3:
		var asteroid2 = pre_asteroid2.instantiate()
		self.call_deferred("add_child", asteroid2)
		asteroid2.position.x = round(randf_range(0.0, 1280.0))
		asteroid2.add_to_group("enemy")
		
	elif  randomEnemy == 4:
		var enemyShip2 = pre_enemyShip2.instantiate()
		self.call_deferred("add_child", enemyShip2)
		enemyShip2.position.x = round(randf_range(0.0, 1280.0))
		enemyShip2.add_to_group("enemy")
		
	elif randomEnemy == 5:
		var asteroid3 = pre_asteroid3.instantiate()
		self.call_deferred("add_child", asteroid3)
		asteroid3.position.x = round(randf_range(0.0, 1280.0))
		asteroid3.add_to_group("enemy")
		
	elif randomEnemy == 6:
		var enemyShip3 = pre_enemyShip3.instantiate()
		self.call_deferred("add_child", enemyShip3)
		enemyShip3.position.x = round(randf_range(0.0, 1280.0))
		enemyShip3.add_to_group("enemy")
		
func _on_timer_2_timeout():
	randomize()
	var randomBoost = round(randf_range(1.0, 2.0))
	
	if randomBoost == 1:
		var medicine = pre_medicine.instantiate()
		self.call_deferred("add_child", medicine)
		medicine.position.x = round(randf_range(0.0, 1280.0))
		medicine.add_to_group("boost")
		
	if randomBoost == 2:
		var shield = pre_shield.instantiate()
		self.call_deferred("add_child", shield)
		shield.position.x = round(randf_range(0.0, 1280.0))
		shield.add_to_group("boost")

func _physics_process(delta):
	# Ajuste de velocidad de enemigos basado en puntos, usando delta para suavizar
	if GlobalScript.points >= 0 and GlobalScript.points <= 20:
		enemy_speed = 75 * delta
	elif GlobalScript.points > 20 and GlobalScript.points <= 50:
		enemy_speed = 125 * delta
	elif GlobalScript.points > 50 and GlobalScript.points <= 100:
		enemy_speed = 175 * delta
	elif GlobalScript.points > 100 and GlobalScript.points <= 150:
		enemy_speed = 250 * delta
	elif GlobalScript.points > 150 and GlobalScript.points <= 200:
		enemy_speed = 325 * delta
	elif GlobalScript.points > 200 and GlobalScript.points <= 300:
		enemy_speed = 400 * delta
	elif GlobalScript.points > 300 and GlobalScript.points <= 400:
		enemy_speed = 500 * delta
	elif GlobalScript.points > 400 and GlobalScript.points <= 500:
		enemy_speed = 600 * delta
	else:
		enemy_speed = 600 * delta

	# Actualiza puntos cada segundo
	time_accumulated += delta
	if time_accumulated >= 1.0:
		GlobalScript.points += 1
		time_accumulated = 0.0
	
	# Actualiza el HUD con puntos y daño
	$HUD/PuntosCantidad.text = str(GlobalScript.points)
	$HUD/DamageCantidad.text = str(GlobalScript.Damage)
	
	$ParallaxBackground/ParallaxLayer.motion_offset.y += 4

func reset_game():
	GlobalScript.points = 0
	GlobalScript.Damage = 0
