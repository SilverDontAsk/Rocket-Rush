extends Node

func _on_single_pressed():
	GlobalScript.points = 0
	GlobalScript.Damage = 0
	get_tree().change_scene_to_file("res://Main/Single Mode/main.tscn")


func _on_back_to_menu_pressed():
	get_tree().change_scene_to_file("res://Main/Title Screen/TitleScreen.tscn")


func _on_versus_mode_pressed():
	GlobalScript.Damage = 0
	get_tree().change_scene_to_file("res://Main/Versus Mode/Versus_main.tscn")

func _ready():
	$Music/menuMusic.play()
