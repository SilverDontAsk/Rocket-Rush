extends Node

var Vpoints = 0
var player1_damage = 0
var player2_damage = 0

const GROUP_VERSUS_ENEMY = "GROUP_VERSUS_ENEMY"
const GROUP_VERSUS_BOOST = "GROUP_VERSUS_BOOST"
const GROUP_VERSUS_PLAYERS = "GROUP_VERSUS_PLAYERS"

func _ready():
	reset_game()  # Reinicia el juego al inicio

func reset_game():
	Vpoints = 0
	player1_damage = 0
	player2_damage = 0
	print("Juego reiniciado. Daño: Jugador 1 - " + str(player1_damage) + ", Jugador 2 - " + str(player2_damage))

func add_damage(player_id, damage_amount):
	if player_id == 1:
		player1_damage += damage_amount
	elif player_id == 2:
		player2_damage += damage_amount

	# Verifica si un jugador ha alcanzado 100 de daño
	if player1_damage >= 100:
		# Lógica de derrota para jugador 1
		print("¡Jugador 1 ha perdido!")
		check_game_over()  # Verifica el fin del juego
	elif player2_damage >= 100:
		# Lógica de derrota para jugador 2
		print("¡Jugador 2 ha perdido!")
		check_game_over()  # Verifica el fin del juego

func check_game_over():
	if player1_damage >= 100:
		print("Player 1 Lost")
		reset_game()
		get_tree().change_scene_to_file("res://Main/Versus Mode/Player2win.tscn")
	elif player2_damage >= 100:
		print("Player 2 Lost")
		reset_game()
		get_tree().change_scene_to_file("res://Main/Versus Mode/Player1win.tscn")
