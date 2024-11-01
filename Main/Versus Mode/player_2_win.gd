extends Control

func _ready():
	$Player2win.text = "Player 2 win"  # Muestra el mensaje de victoria para el jugador 2

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://Main/Title Screen/TitleScreen.tscn")
