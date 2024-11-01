extends Node

@export var mob_scene: Array[PackedScene]
var time_accumulated = 0.0  # Variable para rastrear el tiempo transcurrido
@export var player_speed = 500
@export var enemy_speed = 500
var speed_increase_timer = 0.0 
var speed_increase_interval = 60.0

func _ready():
	new_game()

func _physics_process(delta):
	speed_increase_timer += delta
	if speed_increase_timer >= speed_increase_interval:
		enemy_speed = min(enemy_speed + 50, 1000)
		player_speed = min(player_speed + 25, 700)
		speed_increase_timer = 0.0

	# Actualiza puntos cada segundo
	time_accumulated += delta
	if time_accumulated >= 1.0:
		GlobalScript.points += 1
		time_accumulated = 0.0  # Reiniciar el temporizador
	
	# Actualiza el HUD con puntos y daño
	$HUD/PuntosCantidad.text = str(GlobalScript.points)
	
	$HUD2/PuntosCantidad.text = str(GlobalScript.points)
func spawn_enemy():
	var random_index = randi() % mob_scene.size()
	var selected_scene = mob_scene[random_index]
	
	if selected_scene:
		var obs_instance = selected_scene.instantiate()
		add_child(obs_instance)
		
		var screen_size = get_viewport().get_visible_rect().size
		var spawn_edge = randi() % 3
		
		match spawn_edge:
			0:
				obs_instance.position = Vector2(randf_range(0, screen_size.x), -10)
				obs_instance.rotation = PI / 2
			1:
				obs_instance.position = Vector2(-10, randf_range(0, screen_size.y))
				obs_instance.rotation = 0
			2:
				obs_instance.position = Vector2(screen_size.x + 10, randf_range(0, screen_size.y))
				obs_instance.rotation = PI
		obs_instance.rotation += randf_range(-PI / 8, PI / 8)
		var direction = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0)).normalized()
		obs_instance.rotation = direction.angle()
		if obs_instance.has_method("set_linear_velocity"):
			var velocity = Vector2(enemy_speed, 0).rotated(obs_instance.rotation)
			obs_instance.set_linear_velocity(velocity)

func reset_game():
	GlobalScript.points = 0
func game_over():
	var current_score = GlobalScript.points
	if current_score > GlobalScript.highscore:
		GlobalScript.highscore = current_score
		GlobalScript.save_highscore()
	get_tree().change_scene_to_file("res://Main/Single Mode/Scenes/GameOver.tscn")
func new_game():
	$Player.start($Player1Spawn.position)
	$Player2.start($Player2Spawn.position)
