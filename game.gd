extends Node
@export var obs_scene: PackedScene
var score

# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	get_tree().change_scene_to_file("res://Titlescreen/TitleScreen.tscn")

func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()

func _on_start_timer_timeout() -> void:
	$MobTimer.start()
	$ScoreTimer.start()

func _on_mob_timer_timeout() -> void:
	var obs = obs_scene.instantiate()
	var obs_spawn_location = $ObsPath/ObsSpawnLoc
	obs_spawn_location.progress_ratio = randf()
	var direction = obs_spawn_location.rotation + PI / 2
	obs.position = obs_spawn_location.position
	direction += randf_range(-PI / 4, PI / 4)
	obs.rotation = direction
	
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	obs.linear_velocity = velocity.rotated(direction)
	
	add_child(obs)

func _on_score_timer_timeout() -> void:
	score += 1
