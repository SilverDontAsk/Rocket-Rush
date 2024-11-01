extends Node

func _on_start_pressed():
	get_tree().change_scene_to_file("res://Main/Title Screen/ModeSelection.tscn")


func _on_settings_pressed():
	get_tree().change_scene_to_file("res://Main/Title Screen/settings.tscn")


func _on_exit_pressed():
	get_tree().quit()

func _ready():
	$Music/menuMusic.play()
