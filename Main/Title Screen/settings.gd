extends Control

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://Main/Title Screen/TitleScreen.tscn")

func _ready():
	$Music/menuMusic.play()
