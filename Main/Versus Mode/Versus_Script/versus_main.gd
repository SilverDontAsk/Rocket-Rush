extends Node2D

var pre_ship = preload("res://Main/Versus Mode/Versus Scenes/Versus Enemies/V_ship.tscn")
var pre_asteroid = preload("res://Main/Versus Mode/Versus Scenes/Versus Enemies/V_asteroid.tscn")
var pre_asteroid2 = preload("res://Main/Versus Mode/Versus Scenes/Versus Enemies/V_asteroid2.tscn")
var pre_ship2 = preload("res://Main/Versus Mode/Versus Scenes/Versus Enemies/V_ship.tscn")
var pre_asteroid3 = preload("res://Main/Versus Mode/Versus Scenes/Versus Enemies/V_asteroid3.tscn")
var pre_shield = preload("res://Main/Versus Mode/Versus Scenes/Versus Boosts/V_shield.tscn")
var pre_ship3 = preload("res://Main/Versus Mode/Versus Scenes/Versus Enemies/V_ship3.tscn")
var player_speed = 400
var enemy_speed = 75
var time_accumulated = 0.0
var shield_points = 0
var player_group = []
var enemy_group = []
var boost_group = []

func _ready():
	player_group = get_tree().get_nodes_in_group("VersusPlayers")
	enemy_group = get_tree().get_nodes_in_group("VersusEnemy")
	boost_group = get_tree().get_nodes_in_group("VersusBoost")

func _on_timer_timeout():
	randomize()
	var randomEnemy = round(randf_range(1.0, 6.0))

	if randomEnemy == 1:
		var ship = pre_ship.instantiate()
		self.call_deferred("add_child", ship)
		ship.position.x = round(randf_range(0.0, 1280.0))
		ship.add_to_group("VersusEnemy")
		
	elif randomEnemy == 2:
		var asteroid = pre_asteroid.instantiate()
		self.call_deferred("add_child", asteroid)
		asteroid.position.x = round(randf_range(0.0, 1280.0))
		asteroid.add_to_group("VersusEnemy")
		
	elif randomEnemy == 3:
		var asteroid2 = pre_asteroid2.instantiate()
		self.call_deferred("add_child", asteroid2)
		asteroid2.position.x = round(randf_range(0.0, 1280.0))
		asteroid2.add_to_group("VersusEnemy")
		
	elif randomEnemy == 4:
		var ship2 = pre_ship2.instantiate()
		self.call_deferred("add_child", ship2)
		ship2.position.x = round(randf_range(0.0, 1280.0))
		ship2.add_to_group("VersusEnemy")
		
	elif randomEnemy == 5:
		var asteroid3 = pre_asteroid3.instantiate()
		self.call_deferred("add_child", asteroid3)
		asteroid3.position.x = round(randf_range(0.0, 1280.0))
		asteroid3.add_to_group("VersusEnemy")
		
	elif randomEnemy == 6:
		var ship3 = pre_ship3.instantiate()
		self.call_deferred("add_child", ship3)
		ship3.position.x = round(randf_range(0.0, 1280.0))
		ship3.add_to_group("VersusEnemy")

func _on_timer_2_timeout():
	randomize()
	var randomBoost = round(randf_range(1.0, 1.0))  # Solo escudos disponibles
	
	if randomBoost == 1:
		var shield = pre_shield.instantiate()
		self.call_deferred("add_child", shield)
		shield.position.x = round(randf_range(0.0, 1280.0))
		shield.add_to_group("VersusBoost")

func _physics_process(delta):
	# Ajuste de velocidad de enemigos basado en puntos
	if VersusGlobal.Vpoints >= 0 and VersusGlobal.Vpoints <= 20:
		enemy_speed = 75
	elif VersusGlobal.Vpoints > 20 and VersusGlobal.Vpoints <= 50:
		enemy_speed = 125
	elif VersusGlobal.Vpoints > 50 and VersusGlobal.Vpoints <= 100:
		enemy_speed = 175
	elif VersusGlobal.Vpoints > 100 and VersusGlobal.Vpoints <= 150:
		enemy_speed = 250
	elif VersusGlobal.Vpoints > 150 and VersusGlobal.Vpoints <= 200:
		enemy_speed = 325
	elif VersusGlobal.Vpoints > 200 and VersusGlobal.Vpoints <= 300:
		enemy_speed = 400
	elif VersusGlobal.Vpoints > 300 and VersusGlobal.Vpoints <= 400:
		enemy_speed = 500
	else:
		enemy_speed = 600

	# Actualiza puntos cada segundo
	time_accumulated += delta
	if time_accumulated >= 1.0:
		VersusGlobal.Vpoints += 1
		time_accumulated = 0.0
	
	# Actualiza el HUD con daño
	$HUD/P1Damage.text = "P1Damage: " + str(VersusGlobal.player1_damage)  # Mostrar daño del jugador 1
	$HUD/P2Damage.text = "P2Damage: " + str(VersusGlobal.player2_damage)  # Mostrar daño del jugador 2
	
	$ParallaxBackground/ParallaxLayer.motion_offset.y += 4

func reset_game():
	VersusGlobal.Vpoints = 0
	VersusGlobal.player1_damage = 0
	VersusGlobal.player2_damage = 0
