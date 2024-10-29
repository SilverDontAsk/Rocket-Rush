extends Node

@export var points = 0         # Puntos del jugador
@export var Damage = 0        # Daño del jugador
@export var highscore = 0      # Variable para almacenar el highscore
@export var is_single_player = true  # Simplificado a un solo jugador

func _ready():
	load_highscore()

func save_highscore():
	var file = FileAccess.open("user://highscore.save", FileAccess.WRITE)
	if file:
		file.store_string(str(highscore))
		file.close()

func load_highscore():
	var file = FileAccess.open("user://highscore.save", FileAccess.READ)
	if file:
		highscore = file.get_buffer(file.get_length()).get_string_from_utf8().to_int()
		file.close()
	else:
		highscore = 0  # Si no existe el archivo, empieza en 0
