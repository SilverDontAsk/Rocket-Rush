extends Node

func _ready() -> void:
	load_title_screen()
	
func load_title_screen() -> void:
	var title_scene = ResourceLoader.load("res://Titlescreen/TitleScreen.tscn")
	var title_instance = title_scene.instantiate()
	get_tree().root.call_deferred("add_child", title_instance)
