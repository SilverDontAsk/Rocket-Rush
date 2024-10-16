extends Node

# Path to the different scenes (title, play, settings, credits, highscores)
var title_scene_path = "res://Titlescreen/TitleScreen.tscn"
var player_scene_path = "res://main_character.tscn"
var settings_scene_path = "res://Titlescreen/settings.tscn"
var highscores_scene_path = "res://Highscores.tscn"

# Current scene reference
var current_scene: Node = null

func _ready() -> void:
	# Load the title screen first
	change_scene(title_scene_path)

# Function to change between scenes
func change_scene(scene_path: String) -> void:
	if current_scene:
		current_scene.queue_free()  # Remove the current scene
	var new_scene = load(scene_path).instantiate()
	add_child(new_scene)
	current_scene = new_scene
	
	if scene_path == title_scene_path:
		new_scene.connect("play_pressed", Callable(self, "_on_play_pressed"))
		new_scene.connect("settings_pressed", Callable(self, "_on_settings_pressed"))
		new_scene.connect("highscores_pressed", Callable(self, "_on_highscores_pressed"))
		
func _on_play_pressed():
	change_scene(player_scene_path)
	
func _on_settings_pressed():
	change_scene(settings_scene_path)
	
func _on_highscores_pressed():
	change_scene(highscores_scene_path)
	
func _on_back_to_title():
	change_scene(title_scene_path)
